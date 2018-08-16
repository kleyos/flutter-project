import 'dart:async';
import 'dart:io';
import 'package:add_just/models/account.dart';
import 'package:add_just/models/area.dart';
import 'package:add_just/models/new-project.dart';
import 'package:add_just/models/project.dart';
import 'package:add_just/models/user.dart';
import 'package:add_just/services/api/base.dart';

class Projects extends Base {
  Projects({
    String host
  }) : super(host: host);

  Future<List<Project>> index(Account acc) async {
    ApiResponse resp = await get("/api/orgs/${acc.orgId}/projects",
      headers: {HttpHeaders.authorizationHeader: "Bearer ${acc.accessToken}"});
    if (resp.data == null || List.from(resp.data['projects']).isEmpty) {
      return [];
    }
    return List.from(resp.data['projects']).map((p) => Project.fromApiResponse(p)).toList();
  }

  Future<Project> load(Account acc, int id) async {
    ApiResponse resp = await get("/api/orgs/${acc.orgId}/projects/$id",
      headers: {HttpHeaders.authorizationHeader: "Bearer ${acc.accessToken}"});
    return resp.data != null
      ? Project.fromApiResponse(resp.data)
      : null;
  }

  Future<List<Area>> regions(Account acc) async {
    ApiResponse resp = await get("/api/orgs/${acc.orgId}/regions",
      headers: {HttpHeaders.authorizationHeader: "Bearer ${acc.accessToken}"});
    if (resp.data == null || List.from(resp.data['regions']).isEmpty) {
      return [];
    }
    return List.from(resp.data['regions']).map((a) => Area.fromApiResponse(a)).toList();
  }

  Future<List<User>> users(Account acc) async {
    ApiResponse resp = await get("/api/orgs/${acc.orgId}/users",
      headers: {HttpHeaders.authorizationHeader: "Bearer ${acc.accessToken}"});
    if (resp.data == null || List.from(resp.data['users']).isEmpty) {
      return [];
    }
    return List.from(resp.data['users']).map((e) => User.fromApiResponse(e)).toList();
  }

  Future<ApiResponse> saveNewProject(Account acc, NewProject project) async {
    return await post("/api/orgs/${acc.orgId}/projects",
      headers: {HttpHeaders.authorizationHeader: "Bearer ${acc.accessToken}"},
      body: project.toJson());
  }

  Future<List<String>> availableSections(Account acc) async {
    ApiResponse resp = await get("/api/orgs/${acc.orgId}/sections",
      headers: {HttpHeaders.authorizationHeader: "Bearer ${acc.accessToken}"});
    return resp != null && resp.data['sections'] != null
      ? List.from(resp.data['sections']).map((s) => s.toString()).toList()
      : [];
  }

  Future<ApiResponse> addSectionsToProject(Account acc, List<String> sections, Project prj) async {
    return await post("/api/orgs/${acc.orgId}/projects/${prj.id}/sections",
      headers: {HttpHeaders.authorizationHeader: "Bearer ${acc.accessToken}"},
      body: {'sections': sections});
  }
}
