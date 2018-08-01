import 'dart:async';

import 'package:add_just/services/api/base.dart';

class Login extends Base {
  Login({
    String baseURL
  }) : super(baseURL: baseURL);

  Future<ApiResponse> requestCode(String email) async {
    return await post('login/request-code', body: {"email": email});
  }
}
