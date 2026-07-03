import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_config.dart';

/// Wrapper fino sobre o pacote `http` com a base URL, timeout e
/// desserialização JSON já resolvidos. Todos os services usam este cliente.
class ApiClient {
  final http.Client _client;

  ApiClient([http.Client? client]) : _client = client ?? http.Client();

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  Uri _uri(String path, [Map<String, dynamic>? query]) {
    final base = Uri.parse('${ApiConfig.baseUrl}$path');
    if (query == null || query.isEmpty) return base;
    final qp = query.map((k, v) => MapEntry(k, v?.toString()))
      ..removeWhere((k, v) => v == null);
    return base.replace(queryParameters: qp.cast<String, String>());
  }

  Future<dynamic> get(String path, {Map<String, dynamic>? query}) async {
    final res =
        await _client.get(_uri(path, query), headers: _headers).timeout(ApiConfig.timeout);
    return _decode(res);
  }

  Future<dynamic> post(String path, Map<String, dynamic> body) async {
    final res = await _client
        .post(_uri(path), headers: _headers, body: jsonEncode(body))
        .timeout(ApiConfig.timeout);
    return _decode(res);
  }

  Future<dynamic> put(String path, Map<String, dynamic> body) async {
    final res = await _client
        .put(_uri(path), headers: _headers, body: jsonEncode(body))
        .timeout(ApiConfig.timeout);
    return _decode(res);
  }

  Future<void> delete(String path) async {
    final res = await _client.delete(_uri(path), headers: _headers).timeout(ApiConfig.timeout);
    if (res.statusCode >= 400) {
      throw ApiException(res.statusCode, res.body);
    }
  }

  dynamic _decode(http.Response res) {
    if (res.statusCode >= 400) {
      throw ApiException(res.statusCode, res.body);
    }
    if (res.body.isEmpty) return null;
    return jsonDecode(utf8.decode(res.bodyBytes));
  }

  void close() => _client.close();
}

/// Erro de API com o status HTTP e o corpo da resposta.
class ApiException implements Exception {
  final int statusCode;
  final String body;

  ApiException(this.statusCode, this.body);

  @override
  String toString() => 'ApiException($statusCode): $body';
}
