import 'dart:async';
import 'dart:io';
import 'package:add_just/models/account.dart';
import 'package:add_just/models/area.dart';
import 'package:add_just/models/new-project.dart';
import 'package:add_just/models/project.dart';
import 'package:add_just/models/user.dart';
import 'package:add_just/services/api/base.dart';

class ProjectPool extends Base {
  static final ProjectPool _singleton = new ProjectPool._internal();

  factory ProjectPool() {
    return _singleton;
  }

  ProjectPool._internal();

  Map<int, Project> _projects = {};

  Future<List<Project>> index() async {
    ApiResponse resp = await get("/api/orgs/${Account.current.orgId}/projects",
      headers: {HttpHeaders.authorizationHeader: "Bearer ${Account.current.accessToken}"});
    if (resp.data == null || List.from(resp.data['projects']).isEmpty) {
      return [];
    }
    return List.from(resp.data['projects']).map((p) => Project.fromApiResponse(p)).toList();
  }

  Future<Project> load(int id) async {
    ApiResponse resp = await get("/api/orgs/${Account.current.orgId}/projects/$id",
      headers: {HttpHeaders.authorizationHeader: "Bearer ${Account.current.accessToken}"});
    return resp.data != null
      ? Project.fromApiResponse(resp.data)
      : null;
  }

  Future<List<Area>> regions() async {
    ApiResponse resp = await get("/api/orgs/${Account.current.orgId}/regions",
      headers: {HttpHeaders.authorizationHeader: "Bearer ${Account.current.accessToken}"});
    if (resp.data == null || List.from(resp.data['regions']).isEmpty) {
      return [];
    }
    return List.from(resp.data['regions']).map((a) => Area.fromApiResponse(a)).toList();
  }

  Future<List<User>> users() async {
    ApiResponse resp = await get("/api/orgs/${Account.current.orgId}/users",
      headers: {HttpHeaders.authorizationHeader: "Bearer ${Account.current.accessToken}"});
    if (resp.data == null || List.from(resp.data['users']).isEmpty) {
      return [];
    }
    return List.from(resp.data['users']).map((e) => User.fromApiResponse(e)).toList();
  }

  Future<Project> saveNewProject(NewProject project) async {
    ApiResponse resp = await post("/api/orgs/${Account.current.orgId}/projects",
      headers: {HttpHeaders.authorizationHeader: "Bearer ${Account.current.accessToken}"},
      body: project.toJson());
    return reloadById(resp.data['id']);
  }

  Future<List<String>> availableSections() async {
    ApiResponse resp = await get("/api/orgs/${Account.current.orgId}/sections",
      headers: {HttpHeaders.authorizationHeader: "Bearer ${Account.current.accessToken}"});
    return resp != null && resp.data['sections'] != null
      ? List.from(resp.data['sections']).map((s) => s.toString()).toList()
      : [];
  }

  Future<Project> addSectionsToProject(List<String> sections, int prjId) async {
    await post("/api/orgs/${Account.current.orgId}/projects/$prjId/sections",
      headers: {HttpHeaders.authorizationHeader: "Bearer ${Account.current.accessToken}"},
      body: {'sections': sections});
    return reloadById(prjId);
  }

  //// Post a new scope-item to a project
  //  POST {{host}}/api/orgs/1/projects/1/scope-items
  //  Authorization: Bearer {{amo_token}}
  //  Content-Type: application/json
  //
  //  {"scopes": [{"boqItemId": 1, "sectionId": 1, "quantity": 12}]}
  Future<Project> addBoqItemToSection(int prjId, secId, itemId, num qty) async {
    await post("/api/orgs/${Account.current.orgId}/projects/$prjId/scope-items",
      headers: {HttpHeaders.authorizationHeader: "Bearer ${Account.current.accessToken}"},
      body: {'scopes': [{'boqItemId': itemId, 'sectionId': secId, 'quantity': qty}]});
    return reloadById(prjId);
  }

//  // Finalise the scope of a project
//  POST {{host}}/api/orgs/1/projects/1/finalise-scope
//  Authorization: Bearer {{amo_token}}
//  Content-Type: application/json
//
//  {"ctrId": 10}
//  ###
  Future<Project> finaliseScope(int prjId, ctrId) async {
    await post("/api/orgs/${Account.current.orgId}/projects/$prjId/finalise-scope",
      headers: {HttpHeaders.authorizationHeader: "Bearer ${Account.current.accessToken}"},
      body: {'ctrId': ctrId});
    return reloadById(prjId);
  }

  Future<Project> getById(int id) async {
    _projects[id] ??= await load(id);
    return _projects[id];
  }

  Future<Project> reloadById(int id) async {
    _projects[id] = await load(id);
    return _projects[id];
  }
}
