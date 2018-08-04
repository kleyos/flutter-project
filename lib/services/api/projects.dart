import 'dart:_http';
import 'dart:async';
import 'package:add_just/models/user.dart';
import 'package:add_just/services/api/base.dart';

class Projects extends Base {
  Projects({
    String baseURL
  }) : super(baseURL: baseURL);

  Future<ApiResponse> index(User user) {
    return get("/api/orgs/${user.orgId}/projects",
      headers: {HttpHeaders.authorizationHeader: "Bearer ${user.accessToken}"});
  }
}
