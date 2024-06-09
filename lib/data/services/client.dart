import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:managerapp/data/services/token_manager.dart';

class ClientWithTokenInterceptor {
  final String baseUrl = "https://dummyjson.com";
  final TokenManager tokenManager;

  ClientWithTokenInterceptor({required this.tokenManager});

  Future<http.Response> _handleRequestWithTokenRefresh(http.Request request) async {
    try {
      String? accessToken = await tokenManager.getAccessToken();
      request.headers['Authorization'] = 'Bearer $accessToken';

      final streamedResponse = await request.send();
      if (streamedResponse.statusCode == 401) {
        final newAccessToken = await _refreshAccessToken();
        if (newAccessToken != null) {
          request.headers['Authorization'] = 'Bearer $newAccessToken';
          return await http.Response.fromStream(await request.send());
        }
      }
      return await http.Response.fromStream(streamedResponse);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<String?> _refreshAccessToken() async {
    final refreshToken = await tokenManager.getRefreshToken();
    if (refreshToken == null) return null;

    final response = await http.post(
      Uri.parse('$baseUrl/refresh'),
      body: jsonEncode({'refresh_token': refreshToken}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final newAccessToken = data['accessToken'];
      final newRefreshToken = data['refreshToken'];
      await tokenManager.saveTokens(newAccessToken, newRefreshToken);
      return newAccessToken;
    }
    return null;
  }

  Future<http.Response> get(String endpoint) async {
    final request = http.Request('GET', Uri.parse('$baseUrl$endpoint'));
    return await _handleRequestWithTokenRefresh(request);
  }

  Future<http.Response> post(String endpoint, {required Map<String, dynamic> body}) async {
    final request = http.Request('POST', Uri.parse('$baseUrl$endpoint'));
    request.headers['Content-Type'] = 'application/json';
    request.body = jsonEncode(body);
    return await _handleRequestWithTokenRefresh(request);
  }

  Future<http.Response> put(String endpoint, {required Map<String, dynamic> body}) async {
    final request = http.Request('PUT', Uri.parse('$baseUrl$endpoint'));
    request.headers['Content-Type'] = 'application/json';
    request.body = jsonEncode(body);
    return await _handleRequestWithTokenRefresh(request);
  }

  Future<http.Response> delete(String endpoint) async {
    final request = http.Request('DELETE', Uri.parse('$baseUrl$endpoint'));
    return await _handleRequestWithTokenRefresh(request);
  }
}
