import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pengeluaran.dart';

class PengeluaranService {
  // Constants
  static const _basePath = 'pengeluaran_kuliah';
  final String _baseUrl =
      'https://laili-a1219-default-rtdb.firebaseio.com/$_basePath';

  /// Fetches all pengeluaran records from Firebase
  Future<List<Pengeluaran>> fetchAll() async {
    try {
      final uri = Uri.parse('$_baseUrl.json');
      final response = await http.get(uri);

      _logRequest('GET', uri, response);

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>?;
        return data?.entries
                .map((e) => Pengeluaran.fromJson(e.value, e.key))
                .toList() ??
            [];
      }
      throw _handleError(response);
    } catch (e) {
      throw Exception('Failed to fetch pengeluaran: ${e.toString()}');
    }
  }

  /// Adds a new pengeluaran record
  Future<String> addPengeluaran(Pengeluaran pengeluaran) async {
    try {
      final uri = Uri.parse('$_baseUrl.json');
      final response = await http.post(
        uri,
        body: json.encode(pengeluaran.toJson()),
      );

      _logRequest('POST', uri, response);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return responseData['name']; // Returns the generated ID
      }
      throw _handleError(response);
    } catch (e) {
      throw Exception('Failed to add pengeluaran: ${e.toString()}');
    }
  }

  /// Updates an existing pengeluaran record
  Future<void> updatePengeluaran(Pengeluaran pengeluaran) async {
    try {
      if (pengeluaran.id == null || pengeluaran.id!.isEmpty) {
        throw Exception('Cannot update pengeluaran without ID');
      }

      final uri = Uri.parse('$_baseUrl/${pengeluaran.id}.json');
      final response = await http.patch(
        uri,
        body: json.encode(pengeluaran.toJson()),
      );

      _logRequest('PATCH', uri, response);

      if (response.statusCode != 200) {
        throw _handleError(response);
      }
    } catch (e) {
      throw Exception('Failed to update pengeluaran: ${e.toString()}');
    }
  }

  /// Deletes a pengeluaran record by ID
  Future<void> deletePengeluaran(String id) async {
    try {
      if (id.isEmpty) {
        throw Exception('Cannot delete pengeluaran without ID');
      }

      final uri = Uri.parse('$_baseUrl/$id.json');
      final response = await http.delete(uri);

      _logRequest('DELETE', uri, response);

      if (response.statusCode != 200) {
        throw _handleError(response);
      }
    } catch (e) {
      throw Exception('Failed to delete pengeluaran: ${e.toString()}');
    }
  }

  // Private helper methods
  void _logRequest(String method, Uri uri, http.Response response) {
    print('[$method] ${uri.toString()}');
    print('Response: ${response.statusCode}');
    if (response.body.length < 500) {
      print('Body: ${response.body}');
    } else {
      print('Body: <too long to display>');
    }
  }

  Exception _handleError(http.Response response) {
    final statusCode = response.statusCode;
    final errorBody = response.body;

    switch (statusCode) {
      case 400:
        return Exception('Bad request: $errorBody');
      case 401:
      case 403:
        return Exception('Authentication failed: $errorBody');
      case 404:
        return Exception('Resource not found: $errorBody');
      case 500:
        return Exception('Server error: $errorBody');
      default:
        return Exception('HTTP error $statusCode: $errorBody');
    }
  }
}
