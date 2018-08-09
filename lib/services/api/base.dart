import 'dart:async';
import 'dart:convert';
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

  Future<ApiResponse> post(String path, {Map<String, dynamic> headers, body}) async {
    return _extractResponse(await http.post(Uri.https(_host, path), headers: headers, body: body));
  }

  Future<ApiResponse> get(String path, {Map<String, String> headers}) async {
    return _extractResponse(await http.get(Uri.https(_host, path), headers: headers));
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
