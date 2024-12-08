import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:8080/api';

  Future<Map<String, dynamic>?> register(
      String email, String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      body: {'email': email, 'username': username, 'password': password},
    );
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      body: {'email': email, 'password': password},
    );
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>?> getProfile(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/profile'),
      headers: {'Authorization': 'Bearer $token'},
    );
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>?> logout(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/logout'),
      headers: {'Authorization': 'Bearer $token'},
    );
    return _handleResponse(response);
  }

  Map<String, dynamic>? _handleResponse(http.Response response) {
    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      print('Error: ${response.body}');
      return null;
    }
  }
}
