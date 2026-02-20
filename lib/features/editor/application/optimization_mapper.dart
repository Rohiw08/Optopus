/// Maps the FlowCanvas JSON state to the optimization problem schema
/// required by the backend `/optimize` endpoint.
class OptimizationMapper {
  static Map<String, dynamic> mapToOptimizationRequest({
    required String flowId,
    required String flowName,
    required Map<String, dynamic> canvasStateJson,
  }) {
    // Extract nodes and edges from canvas state
    final nodesJson = canvasStateJson['nodes'] as Map<String, dynamic>? ?? {};
    final edgesJson = canvasStateJson['edges'] as Map<String, dynamic>? ?? {};

    // Build the structure list (defining connections between nodes)
    final structure = <Map<String, dynamic>>[];

    // Map of nodeId -> list of target node ids
    final nodeConnections = <String, List<String>>{};

    for (final edgeData in edgesJson.values) {
      final sourceId = edgeData['sourceNodeId'] as String;
      final targetId = edgeData['targetNodeId'] as String;

      nodeConnections.putIfAbsent(sourceId, () => []).add(targetId);
    }

    // Build structure and data arrays
    final dataList = <Map<String, dynamic>>[];

    for (final entry in nodesJson.entries) {
      final nodeId = entry.key;
      final nodeData = entry.value as Map<String, dynamic>;
      final nodeType = nodeData['type'] as String;

      // Structure entry
      structure.add({
        "node_type": nodeType,
        "node_id": nodeId,
        "connections": nodeConnections[nodeId] ?? [],
      });

      // Data entry
      // In Optopus, the user's filled-in properties might be under "data" or similar
      final properties = nodeData['data'] as Map<String, dynamic>? ?? {};

      // We convert any string properties to the correct types.
      // Fields the backend expects as lists must be converted from strings.
      final cleanProperties = <String, dynamic>{};
      for (final p in properties.entries) {
        cleanProperties[p.key] = _coerceValue(p.key, p.value);
      }

      dataList.add({
        "node_id": nodeId,
        "type": nodeType,
        "properties": cleanProperties,
      });
    }

    // Build edges array
    final edgeList = <Map<String, dynamic>>[];
    for (final edgeData in edgesJson.values) {
      final sourceId = edgeData['sourceNodeId'] as String;
      final targetId = edgeData['targetNodeId'] as String;

      final properties = edgeData['data'] as Map<String, dynamic>? ?? {};

      final cleanProperties = <String, dynamic>{};
      for (final p in properties.entries) {
        cleanProperties[p.key] = _coerceValue(p.key, p.value);
      }

      edgeList.add({
        "source": sourceId,
        "target": targetId,
        "properties": cleanProperties,
      });
    }

    // Construct the final problem payload
    return {
      "header": {"problem_name": flowName, "problem_id": flowId},
      "problem_schema": {
        "objective": {"type": "min", "function": "total_cost"},
        "structure": structure,
      },
      "data": dataList,
      "edges": edgeList,
    };
  }

  /// Converts a raw property value to the type the backend expects.
  ///
  /// Rules:
  /// - Fields that must be lists (`location`, `time_window`) → parsed from
  ///   a comma-separated string, or an empty list when blank.
  /// - Other numeric strings → double.
  /// - Everything else → unchanged.
  static dynamic _coerceValue(String key, dynamic value) {
    // Fields the backend always expects as lists
    const listFields = {'location', 'time_window'};

    if (listFields.contains(key)) {
      if (value == null) return <dynamic>[];
      if (value is List) return value; // already a list
      final str = value.toString().trim();
      if (str.isEmpty) return <dynamic>[];
      // Parse comma-separated → try numeric, fall back to string per token
      return str.split(',').map((token) {
        final t = token.trim();
        return double.tryParse(t) ?? t;
      }).toList();
    }

    // Numeric string coercion for all other fields
    if (value is String) {
      final n = double.tryParse(value);
      if (n != null) return n;
    }
    return value;
  }
}
