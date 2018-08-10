import 'dart:async';
import 'package:add_just/services/api/base.dart';

class Login extends Base {
  Login({
    String host
  }) : super(host: host);

  Future<ApiResponse> requestCode(String email) async {
    return await post('/api/login/request-code', body: {"email": email});
  }

  Future<ApiResponse> requestToken(String email, String code) async {
    return await post('/api/login/mobile', body: {"email": email, "code": code});
  }
}
