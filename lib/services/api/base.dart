import 'dart:async';
import 'dart:convert';
import 'dart:io';

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
}

class Base {
  Base({
    this.host
  });

  String host;

  String get _host => host ?? 'api.staging.termpay.io';

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
    print(uri);
    HttpClientRequest request = await httpClient.postUrl(uri);
    print('Setting headers...');
    request.headers.add(HttpHeaders.contentTypeHeader, 'application/json');
    if (headers != null) {
      headers.forEach((k, v) { request.headers.add(k, v); });
    }
    print('Headers set');
    request.add(utf8.encode(json.encode(body)));
    print('Send body: ${json.encode(body)}');
    HttpClientResponse response = await request.close();
    print('Got response');
    ApiResponse resp = await _extractResponse(response);
    print('Got response: $resp');
    httpClient.close();
    return resp;
  }

  Future<ApiResponse> _extractResponse(HttpClientResponse r) async {
    String body;
    ApiResponse resp;
    print(r);

    switch (r.statusCode) {
      case 200:
        body = await r.transform(utf8.decoder).join();
        resp = ApiResponse.fromResponse(body);
        return resp;
        break;
      case 400:
      case 401:
        body = await r.transform(utf8.decoder).join();
        resp = ApiResponse.fromResponse(body);
        print('Got error: $body, code: ${r.statusCode}');
        throw new Exception(resp.error);
        break;
      default:
        throw new Exception('Failed to perform a request, status: ${r.statusCode}');
        break;
    }
  }
}
