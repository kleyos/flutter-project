import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class ApiResponse {
  ApiResponse.fromResponse(String payload) {
    data = json.decode(payload);
  }

  Map<String, Object> data;

  bool get isError => data.containsKey('type') && data.containsKey('message');

  String get error {
    if (isError) {
      return data['message'];
    }
    return '';
  }

  dynamic operator [](String key) => data[key];
}

class Base {
  Base({
    this.host
  });

  String host;

  String get _host => host ?? 'api.staging.termpay.io';

  Future<ApiResponse> post(String path, {Map<String, Object> headers, body}) async {
    return _extractResponse(await http.post(Uri.https(_host, path),
      headers: headers, body: body));
  }

  Future<ApiResponse> get(String path, {Map<String, String> headers}) async {
    return _extractResponse(await http.get(Uri.https(_host, path), headers: headers));
  }

  Future<String> postJson(String path, {Map<String, String> headers, Map<String, dynamic> body}) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.https(_host, path));
    request.headers.set('content-type', 'application/json');
    headers.forEach((k, v) => request.headers.set(k, v));
    request.add(utf8.encode(json.encode(body)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    return reply;
  }

  ApiResponse _extractResponse(Response r) {
    switch (r.statusCode) {
      case 200:
        ApiResponse resp = ApiResponse.fromResponse(r.body);
        return resp;
        break;
      case 400:
      case 401:
        ApiResponse resp = ApiResponse.fromResponse(r.body);
        throw new Exception(resp.error);
        break;
      default:
        throw new Exception('Failed to perform a request');
        break;
    }
  }
}
