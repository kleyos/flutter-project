import 'dart:async';
import 'dart:io';
import 'package:add_just/models/account.dart';
import 'package:add_just/models/new-project.dart';
import 'package:add_just/services/api/base.dart';

class Projects extends Base {
  Projects({
    String host
  }) : super(host: host);

  Future<ApiResponse> index(Account acc) async {
    return await get("/api/orgs/${acc.orgId}/projects",
      headers: {HttpHeaders.authorizationHeader: "Bearer ${acc.accessToken}"});
  }

  Future<ApiResponse> regions(Account acc) async {
    return await get("/api/orgs/${acc.orgId}/regions",
      headers: {HttpHeaders.authorizationHeader: "Bearer ${acc.accessToken}"});
  }

  Future<ApiResponse> users(Account acc) async {
    return await get("/api/orgs/${acc.orgId}/users",
      headers: {HttpHeaders.authorizationHeader: "Bearer ${acc.accessToken}"});
  }

  Future<ApiResponse> saveNewProject(Account acc, NewProject project) async {
    return await post("/api/orgs/${acc.orgId}/projects",
      headers: {HttpHeaders.authorizationHeader: "Bearer ${acc.accessToken}"},
      body: project.toJson());
  }
}
