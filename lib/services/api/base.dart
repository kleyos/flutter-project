import 'dart:async';
import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
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
    final response = await http.post(Path.join(baseURL, path), headers: headers, body: body);

    switch(response.statusCode) {
      case 200:
        ApiResponse resp = ApiResponse.fromResponse(response.body);
        return resp;
        break;
      case 400:
      case 401:
        ApiResponse resp = ApiResponse.fromResponse(response.body);
        _lastError = resp.error;
        break;
      default:
        _lastError = 'Failed to perform a request';
        break;
    }

    return null;
  }
}
