import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:add_just/models/account.dart';

class ApiResponse {
  ApiResponse.fromResponse(String payload) {
    data = json.decode(payload);
  }

  Map<String, Object> data;

  bool get isError => (data.containsKey('type') && data.containsKey('message')) ||
    data.containsKey('error');

  String get error {
    if (isError) {
      return data['message'] ?? data['error'];
    }
    return '';
  }

  dynamic operator [](String key) => data[key];

  String toString() {
    return data.toString();
  }
}

class Base {
  Base({
    this.host
  });

  String host;

  String get _host => host ?? 'api.staging.termpay.io';
  Map<String, String> get authHeader => {HttpHeaders.authorizationHeader: "Bearer ${Account.current.accessToken}"};

  Future<ApiResponse> get(String path, {Map<String, String> headers}) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.getUrl(Uri.https(_host, path));
    request.headers.add(HttpHeaders.contentTypeHeader, 'application/json');
    if (headers != null) {
      headers.forEach((k, v) { request.headers.add(k, v); });
    }
    HttpClientResponse response = await request.close();
    ApiResponse resp = await _extractResponse(response);
    httpClient.close();
    return resp;
  }

  Future<ApiResponse> post(String path, {Map<String, String> headers, Map<String, dynamic> body}) async {
    HttpClient httpClient = new HttpClient();
    Uri uri = Uri.https(_host, path);
    HttpClientRequest request = await httpClient.postUrl(uri);
    request.headers.add(HttpHeaders.contentTypeHeader, 'application/json');
    if (headers != null) {
      headers.forEach((k, v) { request.headers.add(k, v); });
    }
    request.add(utf8.encode(json.encode(body)));
    print('Send body: ${json.encode(body)}');
    HttpClientResponse response = await request.close();
    ApiResponse resp = await _extractResponse(response);
    print('Got response: $resp');
    httpClient.close();
    return resp;
  }

  Future<ApiResponse> delete(String path, {Map<String, String> headers}) async {
    HttpClient httpClient = new HttpClient();
    Uri uri = Uri.https(_host, path);
    HttpClientRequest request = await httpClient.deleteUrl(uri);
    request.headers.add(HttpHeaders.contentTypeHeader, 'application/json');
    if (headers != null) {
      headers.forEach((k, v) { request.headers.add(k, v); });
    }
    HttpClientResponse response = await request.close();
    ApiResponse resp = await _extractResponse(response);
    print('Got response: $resp');
    httpClient.close();
    return resp;
  }

  Future<ApiResponse> _extractResponse(HttpClientResponse r) async {
    String body;
    ApiResponse resp;

    switch (r.statusCode) {
      case 200:
        body = await r.transform(utf8.decoder).join();
        resp = ApiResponse.fromResponse(body);
        print('Got response: $resp');
        return resp;
        break;
      case 400:
      case 401:
      case 404:
        body = await r.transform(utf8.decoder).join();
        resp = ApiResponse.fromResponse(body);
        print('Got error: $body, code: ${r.statusCode}, body: $body');
        throw new Exception(resp.error);
        break;
      default:
        throw new Exception('Failed to perform a request, status: ${r.statusCode}');
        break;
    }
  }
}
