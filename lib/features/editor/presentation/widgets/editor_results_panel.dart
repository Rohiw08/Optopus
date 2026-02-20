import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flow_canvas/flow_canvas.dart';
import 'package:optopus/features/editor/application/optimization_mapper.dart';
import 'package:optopus/features/editor/presentation/controllers/editor_controller.dart';
import 'package:optopus/features/editor/presentation/controllers/right_panel_controller.dart';
import 'package:optopus/features/nodes/presentation/providers/node_types_provider.dart';
import 'package:optopus/core/widgets/loading_screen.dart';
import 'package:optopus/core/widgets/error_screen.dart';
import 'package:optopus/core/widgets/search_bar.dart';

/// Unified expandable/hidable right sidebar panel.
/// Renders: node library | canvas JSON | API payload | optimization results.
class EditorRightPanel extends ConsumerWidget {
  final FlowCanvasController controller;
  final String? flowId;
  final String? flowName;

  const EditorRightPanel({
    super.key,
    required this.controller,
    this.flowId,
    this.flowName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final panelType = ref.watch(rightPanelControllerProvider);
    if (panelType == null) return const SizedBox.shrink();

    final (title, icon) = switch (panelType) {
      RightPanelType.nodes => ('Nodes', Icons.widgets_outlined),
      RightPanelType.json => ('Canvas JSON', Icons.data_object),
      RightPanelType.apiPayload => ('API Payload', Icons.send_outlined),
      RightPanelType.results => ('Results', Icons.analytics_outlined),
    };

    final width = panelType == RightPanelType.nodes ? 300.0 : 280.0;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      width: width,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border(
            left: BorderSide(color: Theme.of(context).dividerColor, width: 0.5),
          ),
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceBright,
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).dividerColor,
                    width: 0.5,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    icon,
                    size: 14,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () =>
                        ref.read(rightPanelControllerProvider.notifier).hide(),
                    borderRadius: BorderRadius.circular(4),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Icon(
                        Icons.close,
                        size: 14,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withAlpha(150),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Body
            Expanded(
              child: switch (panelType) {
                RightPanelType.nodes => _NodesPanelBody(controller: controller),
                RightPanelType.json => _CanvasJsonPanelBody(
                  controller: controller,
                ),
                RightPanelType.apiPayload => _ApiPayloadPanelBody(
                  controller: controller,
                  flowId: flowId,
                  flowName: flowName,
                ),
                RightPanelType.results => _ResultsPanelBody(
                  controller: controller,
                ),
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Nodes Panel ──────────────────────────────────────────────────────────────

class _NodesPanelBody extends ConsumerStatefulWidget {
  final FlowCanvasController controller;
  const _NodesPanelBody({required this.controller});

  @override
  ConsumerState<_NodesPanelBody> createState() => _NodesPanelBodyState();
}

class _NodesPanelBodyState extends ConsumerState<_NodesPanelBody> {
  String _search = '';

  @override
  Widget build(BuildContext context) {
    final nodeTypesAsync = ref.watch(nodeTypesProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: CustomSearchBar(
            height: 35,
            width: double.infinity,
            hintText: 'Search nodes...',
            onChanged: (v) => setState(() => _search = v.toLowerCase()),
          ),
        ),
        Divider(height: 1, color: Theme.of(context).dividerColor),
        Expanded(
          child: nodeTypesAsync.when(
            data: (nodes) {
              final filtered = _search.isEmpty
                  ? nodes
                  : nodes
                        .where(
                          (n) =>
                              n.type.toLowerCase().contains(_search) ||
                              n.description.toLowerCase().contains(_search),
                        )
                        .toList();

              if (filtered.isEmpty) {
                return Center(
                  child: Text(
                    'No nodes found',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withAlpha(100),
                    ),
                  ),
                );
              }

              return ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final node = filtered[index];
                  return _NodeTile(
                    type: node.type,
                    description: node.description,
                    domain: node.domain,
                    onDragStarted: () =>
                        ref.read(rightPanelControllerProvider.notifier).hide(),
                  );
                },
              );
            },
            loading: () => const Center(child: LoadingScreen()),
            error: (err, _) => ErrorScreen(message: err.toString()),
          ),
        ),
      ],
    );
  }
}

class _NodeTile extends StatelessWidget {
  final String type;
  final String description;
  final String domain;
  final VoidCallback onDragStarted;

  const _NodeTile({
    required this.type,
    required this.description,
    required this.domain,
    required this.onDragStarted,
  });

  IconData get _icon {
    switch (domain) {
      case 'logistics':
        return Icons.local_shipping;
      case 'manufacturing':
        return Icons.precision_manufacturing;
      case 'aviation':
        return Icons.flight;
      default:
        return Icons.category;
    }
  }

  Color get _color {
    switch (domain) {
      case 'logistics':
        return Colors.blueAccent;
      case 'manufacturing':
        return Colors.amber;
      case 'aviation':
        return Colors.lightBlue;
      default:
        return Colors.deepOrange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Draggable<String>(
      data: type,
      onDragStarted: onDragStarted,
      feedback: Material(
        color: Colors.transparent,
        child: Container(
          width: 200,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(blurRadius: 8, color: Colors.black.withAlpha(50)),
            ],
          ),
          child: Row(
            children: [
              Icon(_icon, color: _color, size: 24),
              const SizedBox(width: 10),
              Text(
                type.toUpperCase(),
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
      child: ListTile(
        dense: true,
        leading: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: _color.withAlpha(25),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _color.withAlpha(50), width: 1),
          ),
          child: Icon(_icon, color: _color, size: 20),
        ),
        title: Text(
          type.toUpperCase(),
          style: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 13),
        ),
        subtitle: Text(
          description,
          style: GoogleFonts.inter(
            fontSize: 11,
            color: Theme.of(context).colorScheme.onSurface.withAlpha(140),
          ),
        ),
        hoverColor: Theme.of(context).hoverColor,
      ),
    );
  }
}

// ─── Canvas JSON Panel ────────────────────────────────────────────────────────

class _CanvasJsonPanelBody extends StatefulWidget {
  final FlowCanvasController controller;
  const _CanvasJsonPanelBody({required this.controller});

  @override
  State<_CanvasJsonPanelBody> createState() => _CanvasJsonPanelBodyState();
}

class _CanvasJsonPanelBodyState extends State<_CanvasJsonPanelBody> {
  late String _jsonString;
  bool _isEditing = false;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _refresh();
    widget.controller.addListener(_onCanvasChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onCanvasChanged);
    _textController.dispose();
    super.dispose();
  }

  void _onCanvasChanged(FlowCanvasState _) {
    if (mounted && !_isEditing) setState(_refresh);
  }

  void _refresh() {
    _jsonString = const JsonEncoder.withIndent(
      '  ',
    ).convert(widget.controller.currentState.toJson());
  }

  void _applyJson() {
    try {
      final map = jsonDecode(_textController.text) as Map<String, dynamic>;
      final state = FlowCanvasState.fromJson(map);
      widget.controller.load(state);
      setState(() => _isEditing = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Canvas updated successfully.'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to parse JSON: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _isEditing ? 'Edit Mode' : 'Read-Only Mode',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
                ),
              ),
              if (!_isEditing)
                TextButton.icon(
                  onPressed: () {
                    _textController.text = _jsonString;
                    setState(() => _isEditing = true);
                  },
                  icon: const Icon(Icons.edit, size: 14),
                  label: const Text(
                    'Edit JSON',
                    style: TextStyle(fontSize: 11),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 0,
                    ),
                    minimumSize: const Size(0, 24),
                  ),
                )
              else
                Row(
                  children: [
                    TextButton(
                      onPressed: () => setState(() => _isEditing = false),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 0,
                        ),
                        minimumSize: const Size(0, 24),
                        foregroundColor: Theme.of(
                          context,
                        ).colorScheme.onSurface.withAlpha(150),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: _applyJson,
                      icon: const Icon(Icons.check, size: 14),
                      label: const Text(
                        'Apply',
                        style: TextStyle(fontSize: 11),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 0,
                        ),
                        minimumSize: const Size(0, 24),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
        Divider(height: 1, color: Theme.of(context).dividerColor),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: _isEditing
                ? TextField(
                    controller: _textController,
                    maxLines: null,
                    style: GoogleFonts.firaCode(
                      fontSize: 10.5,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withAlpha(180),
                      height: 1.5,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Paste flow JSON here...',
                    ),
                  )
                : SelectableText(
                    _jsonString,
                    style: GoogleFonts.firaCode(
                      fontSize: 10.5,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withAlpha(180),
                      height: 1.5,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}

// ─── API Payload Panel ────────────────────────────────────────────────────────

class _ApiPayloadPanelBody extends StatefulWidget {
  final FlowCanvasController controller;
  final String? flowId;
  final String? flowName;

  const _ApiPayloadPanelBody({
    required this.controller,
    this.flowId,
    this.flowName,
  });

  @override
  State<_ApiPayloadPanelBody> createState() => _ApiPayloadPanelBodyState();
}

class _ApiPayloadPanelBodyState extends State<_ApiPayloadPanelBody> {
  late String _jsonString;

  @override
  void initState() {
    super.initState();
    _refresh();
    widget.controller.addListener(_onCanvasChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onCanvasChanged);
    super.dispose();
  }

  void _onCanvasChanged(FlowCanvasState _) {
    if (mounted) setState(_refresh);
  }

  void _refresh() {
    final canvasJson = widget.controller.currentState.toJson();
    try {
      final payload = OptimizationMapper.mapToOptimizationRequest(
        flowId: widget.flowId ?? 'preview',
        flowName: widget.flowName ?? 'preview',
        canvasStateJson: canvasJson,
      );
      _jsonString = const JsonEncoder.withIndent('  ').convert(payload);
    } catch (e) {
      _jsonString = 'Error generating payload:\n$e';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: SelectableText(
        _jsonString,
        style: GoogleFonts.firaCode(
          fontSize: 10.5,
          color: Theme.of(context).colorScheme.onSurface.withAlpha(180),
          height: 1.5,
        ),
      ),
    );
  }
}

// ─── Results Panel ────────────────────────────────────────────────────────────

class _ResultsPanelBody extends ConsumerWidget {
  final FlowCanvasController controller;

  const _ResultsPanelBody({required this.controller});

  Map<String, String> _buildNodeNames() {
    final canvasJson = controller.currentState.toJson();
    final nodesJson = canvasJson['nodes'] as Map<String, dynamic>? ?? {};
    final names = <String, String>{};

    for (final entry in nodesJson.entries) {
      final id = entry.key;
      final nodeData = entry.value as Map<String, dynamic>;
      final type = (nodeData['type'] as String?)?.toUpperCase() ?? 'NODE';

      final props = nodeData['data'] as Map<String, dynamic>? ?? {};
      final customName = props['name'] as String?;

      if (customName != null && customName.isNotEmpty) {
        names[id] = customName;
      } else {
        final shortId = id.replaceAll('node_', '');
        final displayId = shortId.length > 4
            ? shortId.substring(0, 4)
            : shortId;
        names[id] = '$type ($displayId)';
      }
    }
    return names;
  }

  String _formatFlowKey(String key, Map<String, String> names) {
    String formattedStr = key;
    // Replace all known node IDs with their friendly names
    for (final entry in names.entries) {
      formattedStr = formattedStr.replaceAll(entry.key, entry.value);
    }
    return formattedStr;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final execState = ref.watch(editorControllerProvider);

    return execState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'Error:\n$err',
          style: const TextStyle(color: Colors.red, fontSize: 11),
        ),
      ),
      data: (data) {
        if (data == null) {
          return Center(
            child: Text(
              'No results yet.\nRun a flow to see results here.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: Theme.of(context).colorScheme.onSurface.withAlpha(100),
              ),
            ),
          );
        }

        final flows = data['flows'] as Map<String, dynamic>? ?? {};
        final inventory = data['inventory'] as Map<String, dynamic>? ?? {};
        final objValue = data['objective_value'];
        final success = data['success'] as bool? ?? false;

        // Try common status field names the backend might use
        final status =
            (data['status'] ??
                    data['solver_status'] ??
                    data['termination_condition'] ??
                    (success ? 'optimal' : 'infeasible'))
                ?.toString() ??
            'unknown';

        // Try to surface any human-readable backend message
        final message =
            (data['message'] ??
                    data['detail'] ??
                    data['error'] ??
                    data['reason'])
                ?.toString();

        final nodeNames = _buildNodeNames();

        return SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    success ? Icons.check_circle_outline : Icons.error_outline,
                    size: 13,
                    color: success ? Colors.green : Colors.red,
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      status,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: success ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
              if (!success && message != null) ...[
                const SizedBox(height: 6),
                Text(
                  message,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    color: Colors.red.withAlpha(180),
                  ),
                ),
              ],
              if (objValue != null) ...[
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Objective Value',
                        style: GoogleFonts.inter(
                          fontSize: 9,
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer.withAlpha(160),
                        ),
                      ),
                      Text(
                        objValue.toString(),
                        style: GoogleFonts.firaCode(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              if (flows.isNotEmpty) ...[
                const SizedBox(height: 14),
                _Label(icon: Icons.swap_horiz, label: 'Flow Quantities'),
                const SizedBox(height: 6),
                ...flows.entries.map(
                  (e) => _Row(
                    label: _formatFlowKey(e.key, nodeNames),
                    value: '${e.value}',
                  ),
                ),
              ],
              if (inventory.isNotEmpty) ...[
                const SizedBox(height: 14),
                _Label(icon: Icons.inventory_2_outlined, label: 'Inventory'),
                const SizedBox(height: 6),
                ...inventory.entries.map(
                  (e) => _Row(
                    label: _formatFlowKey(e.key, nodeNames),
                    value: '${e.value}',
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _Label extends StatelessWidget {
  final IconData icon;
  final String label;
  const _Label({required this.icon, required this.label});
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(icon, size: 12, color: Theme.of(context).colorScheme.primary),
      const SizedBox(width: 5),
      Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.onSurface.withAlpha(160),
        ),
      ),
    ],
  );
}

class _Row extends StatelessWidget {
  final String label;
  final String value;
  const _Row({required this.label, required this.value});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 10,
              color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
            ),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          value,
          style: GoogleFonts.firaCode(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    ),
  );
}
