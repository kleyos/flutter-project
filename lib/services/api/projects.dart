import 'dart:async';
import 'package:add_just/models/user.dart';
import 'package:add_just/services/api/base.dart';

class Projects extends Base {
  Projects({
    String baseURL
  }) : super(baseURL: baseURL);

  Future<ApiResponse> index(User user) async {
    return await get("/api/orgs/${user.orgId}/projects",
      headers: {"Authorization": "Bearer ${user.accessToken}"});
  }
}
