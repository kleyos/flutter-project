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

  bool get isError => data.containsKey('type') && data['type'] == 'api_error';

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

    if (response.statusCode == 200) {
      ApiResponse resp = ApiResponse.fromResponse(response.body);
      if (resp.error.isNotEmpty) {
        _lastError = resp.error;
        return null;
      }
      return resp;
    } else {
      _lastError = 'Failed to perform a request';
      return null;
    }
  }
}
