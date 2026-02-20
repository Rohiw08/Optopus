import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class OptopusApiClient {
  final String baseUrl;

  OptopusApiClient({
    this.baseUrl = 'http://127.0.0.1:8000',
  }); // Use 10.0.2.2 if on Android Emulator

  Future<List<dynamic>> getEntities({String? domain}) async {
    final url = domain != null
        ? '$baseUrl/entities?domain=$domain'
        : '$baseUrl/entities';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    } else {
      throw Exception('Failed to load entities: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> getEntitySchema(String type) async {
    final response = await http.get(Uri.parse('$baseUrl/entities/$type'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load entity schema: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> optimize(
    Map<String, dynamic> problem, {
    String solver = 'glpk',
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/optimize'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'problem': problem,
        'solver': solver,
        'run_forecasting': false,
      }),
    );

    debugPrint('=== OPTIMIZE RESPONSE (${response.statusCode}) ===');
    debugPrint(response.body);
    debugPrint('=============================================');

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception(
        'Failed to optimize: ${response.statusCode}\n${response.body}',
      );
    }
  }
}
