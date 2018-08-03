import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:path/path.dart' as Path;

class ApiResponse {
  ApiResponse.fromResponse(String payload) {
    data = json.decode(payload);
  }

  Map<String, dynamic> data;

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
    @required this.baseURL
  });

  final String baseURL;
  String _lastError;

  bool get hasError => lastError != null && lastError.isNotEmpty;
  String get lastError => _lastError == null ? '' : _lastError;

  Future<dynamic> post(String path, {Map<String, dynamic> headers, body}) async {
    return _extractResponse(await http.post(Path.join(baseURL, path),
      headers: headers, body: body));
  }

  Future<dynamic> get(String path, {Map<String, dynamic> headers}) async {
    return _extractResponse(await http.get(Path.join(baseURL, path),
      headers: headers));
  }

  ApiResponse _extractResponse(Response r) {
    switch(r.statusCode) {
      case 200:
        ApiResponse resp = ApiResponse.fromResponse(r.body);
        return resp;
        break;
      case 400:
      case 401:
        ApiResponse resp = ApiResponse.fromResponse(r.body);
        _lastError = resp.error;
        break;
      default:
        _lastError = 'Failed to perform a request';
        break;
    }
    return null;
  }
}
