import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ============================================
// SIMPLE OPTOPUS FLUTTER EXAMPLE
// ============================================

void main() => runApp(OptopusApp());

class OptopusApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Optopus Demo', home: SimpleOptimizationDemo());
  }
}

// ============================================
// DATA MODELS
// ============================================

class OptopusNode {
  final String id;
  final String type;
  Map<String, dynamic> properties;
  Offset position;
  List<String> connections;

  OptopusNode({
    required this.id,
    required this.type,
    required this.properties,
    this.position = Offset.zero,
    this.connections = const [],
  });

  Map<String, dynamic> toDataJson() => {
    'node_id': id,
    'type': type,
    'properties': properties,
  };

  Map<String, dynamic> toStructureJson() => {
    'node_type': type,
    'node_id': id,
    'connections': connections,
  };
}

class OptopusEdge {
  final String source;
  final String target;
  Map<String, dynamic> properties;
  double? flowValue; // Set after optimization

  OptopusEdge({
    required this.source,
    required this.target,
    this.properties = const {},
  });

  Map<String, dynamic> toJson() => {
    'source': source,
    'target': target,
    'properties': properties,
  };
}

// ============================================
// DEMO PAGE
// ============================================

class SimpleOptimizationDemo extends StatefulWidget {
  @override
  _SimpleOptimizationDemoState createState() => _SimpleOptimizationDemoState();
}

class _SimpleOptimizationDemoState extends State<SimpleOptimizationDemo> {
  List<OptopusNode> nodes = [];
  List<OptopusEdge> edges = [];
  Map<String, dynamic>? result;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _createSampleProblem();
  }

  void _createSampleProblem() {
    // Create a simple supply chain: Factory -> Warehouse -> Customer

    nodes = [
      OptopusNode(
        id: 'factory',
        type: 'source',
        position: Offset(100, 200),
        properties: {'capacity': 1000, 'variable_cost': 10, 'fixed_cost': 500},
        connections: ['warehouse'],
      ),
      OptopusNode(
        id: 'warehouse',
        type: 'warehouse',
        position: Offset(350, 200),
        properties: {'capacity': 500, 'holding_cost': 2},
        connections: ['customer'],
      ),
      OptopusNode(
        id: 'customer',
        type: 'sink',
        position: Offset(600, 200),
        properties: {'demand': 300},
        connections: [],
      ),
    ];

    edges = [
      OptopusEdge(
        source: 'factory',
        target: 'warehouse',
        properties: {'cost': 5},
      ),
      OptopusEdge(
        source: 'warehouse',
        target: 'customer',
        properties: {'cost': 3},
      ),
    ];
  }

  Future<void> _solveOptimization() async {
    setState(() => isLoading = true);

    try {
      // Build problem JSON
      final problemJson = {
        'header': {
          'problem_name': 'Simple Supply Chain',
          'problem_id': DateTime.now().millisecondsSinceEpoch.toString(),
        },
        'schema': {
          'objective': {'type': 'min', 'function': 'total_cost'},
          'structure': nodes.map((n) => n.toStructureJson()).toList(),
        },
        'data': nodes.map((n) => n.toDataJson()).toList(),
        'edges': edges.map((e) => e.toJson()).toList(),
      };

      // SINGLE API CALL - This is all you need!
      final response = await http.post(
        Uri.parse('http://localhost:8000/optimizer/solve'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'problem_input': problemJson,
          'solver': 'glpk',
          'run_forecasting': false,
          'verbose': false,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Update edges with flow values
        if (data['flows'] != null) {
          for (var key in data['flows'].keys) {
            final edge = edges.firstWhere(
              (e) =>
                  '${e.source}->${e.target}' == key ||
                  '${e.source}' == key.split('->')[0],
              orElse: () => edges.first,
            );
            edge.flowValue = (data['flows'][key] as num).toDouble();
          }
        }

        setState(() {
          result = data;
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Optopus Optimization Demo'),
        actions: [
          IconButton(
            icon: Icon(Icons.play_arrow),
            onPressed: isLoading ? null : _solveOptimization,
            tooltip: 'Solve Optimization',
          ),
        ],
      ),
      body: Column(
        children: [
          // Canvas Area
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.grey[100],
              child: CustomPaint(
                painter: NetworkPainter(nodes, edges),
                child: Container(),
              ),
            ),
          ),

          // Results Area
          Expanded(flex: 1, child: _buildResultsPanel()),
        ],
      ),
    );
  }

  Widget _buildResultsPanel() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (result == null) {
      return Center(child: Text('Click ▶ to solve optimization'));
    }

    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Results:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('✅ Success: ${result!['success']}'),
          Text(
            '💰 Total Cost: \$${result!['objective_value']?.toStringAsFixed(2)}',
          ),
          Text('⏱️ Solve Time: ${result!['solve_time']?.toStringAsFixed(3)}s'),
          SizedBox(height: 8),
          Text('Flows:', style: TextStyle(fontWeight: FontWeight.bold)),
          ...((result!['flows'] as Map?)?.entries.map(
                (e) => Text('  ${e.key}: ${e.value}'),
              ) ??
              []),
        ],
      ),
    );
  }
}

// ============================================
// CANVAS PAINTER
// ============================================

class NetworkPainter extends CustomPainter {
  final List<OptopusNode> nodes;
  final List<OptopusEdge> edges;

  NetworkPainter(this.nodes, this.edges);

  @override
  void paint(Canvas canvas, Size size) {
    // Draw edges
    for (var edge in edges) {
      final source = nodes.firstWhere((n) => n.id == edge.source);
      final target = nodes.firstWhere((n) => n.id == edge.target);

      final paint = Paint()
        ..color = edge.flowValue != null ? Colors.green : Colors.grey
        ..strokeWidth = edge.flowValue != null ? 3 : 2;

      canvas.drawLine(
        Offset(source.position.dx + 60, source.position.dy + 30),
        Offset(target.position.dx, target.position.dy + 30),
        paint,
      );

      // Draw flow value
      if (edge.flowValue != null) {
        final midpoint = Offset(
          (source.position.dx + target.position.dx) / 2 + 30,
          (source.position.dy + target.position.dy) / 2 + 15,
        );

        final textPainter = TextPainter(
          text: TextSpan(
            text: '${edge.flowValue?.toInt()}',
            style: TextStyle(
              color: Colors.green,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        textPainter.paint(canvas, midpoint);
      }
    }

    // Draw nodes
    for (var node in nodes) {
      _drawNode(canvas, node);
    }
  }

  void _drawNode(Canvas canvas, OptopusNode node) {
    final rect = Rect.fromLTWH(node.position.dx, node.position.dy, 120, 60);

    // Background
    final bgPaint = Paint()
      ..color = _getNodeColor(node.type)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, Radius.circular(8)),
      bgPaint,
    );

    // Border
    final borderPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, Radius.circular(8)),
      borderPaint,
    );

    // Icon & Text
    final textPainter = TextPainter(
      text: TextSpan(
        text: '${_getNodeIcon(node.type)} ${node.type}\n${node.id}',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout(maxWidth: 110);
    textPainter.paint(
      canvas,
      Offset(node.position.dx + 10, node.position.dy + 15),
    );
  }

  Color _getNodeColor(String type) {
    switch (type) {
      case 'source':
        return Colors.blue;
      case 'sink':
        return Colors.red;
      case 'warehouse':
        return Colors.orange;
      case 'vehicle':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  String _getNodeIcon(String type) {
    switch (type) {
      case 'source':
        return '🏭';
      case 'sink':
        return '🎯';
      case 'warehouse':
        return '📦';
      case 'vehicle':
        return '🚚';
      default:
        return '⚙️';
    }
  }

  @override
  bool shouldRepaint(NetworkPainter oldDelegate) => true;
}
