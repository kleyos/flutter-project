import 'dart:async';
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
      headers: authHeader);
    if (resp.data == null || List.from(resp.data['projects']).isEmpty) {
      return [];
    }
    return List.from(resp.data['projects']).map((p) => Project.fromApiResponse(p)).toList();
  }

  Future<Project> load(int id) async {
    ApiResponse resp = await get("/api/orgs/${Account.current.orgId}/projects/$id",
      headers: authHeader);
    return resp.data != null
      ? Project.fromApiResponse(resp.data)
      : null;
  }

  Future<List<Area>> regions() async {
    ApiResponse resp = await get("/api/orgs/${Account.current.orgId}/regions",
      headers: authHeader);
    if (resp.data == null || List.from(resp.data['regions']).isEmpty) {
      return [];
    }
    return List.from(resp.data['regions']).map((a) => Area.fromApiResponse(a)).toList();
  }

  Future<List<User>> users() async {
    ApiResponse resp = await get("/api/orgs/${Account.current.orgId}/users",
      headers: authHeader);
    if (resp.data == null || List.from(resp.data['users']).isEmpty) {
      return [];
    }
    return List.from(resp.data['users']).map((e) => User.fromApiResponse(e)).toList();
  }

  Future<Project> saveNewProject(NewProject project) async {
    ApiResponse resp = await post("/api/orgs/${Account.current.orgId}/projects",
      headers: authHeader,
      body: project.toJson());
    return reloadById(resp.data['id']);
  }

  Future<List<String>> availableSections() async {
    ApiResponse resp = await get("/api/orgs/${Account.current.orgId}/sections",
      headers: authHeader);
    return resp != null && resp.data['sections'] != null
      ? List.from(resp.data['sections']).map((s) => s as String).toList()
      : [];
  }

  Future<Project> addSectionsToProject(List<String> sections, int prjId) async {
    await post("/api/orgs/${Account.current.orgId}/projects/$prjId/sections",
      headers: authHeader,
      body: {'sections': sections});
    return reloadById(prjId);
  }

  Future<Project> addBoqItemToSection(int prjId, secId, itemId, num qty) async {
    final payload = {'boqItemId': itemId, 'quantity': qty};
    if (secId != null ){
      payload['sectionId'] = secId;
    }
    await post("/api/orgs/${Account.current.orgId}/projects/$prjId/scope-items",
      headers: authHeader, body: payload);
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
      headers: authHeader,
      body: {'ctrId': ctrId});
    return reloadById(prjId);
  }

  Future<Project> setScopeItemQuantity(int prjId, itemID, num quantity) async {
    await post("/api/orgs/${Account.current.orgId}/projects/$prjId/scope-items/$itemID",
      headers: authHeader,
      body: {'quantity': quantity});
    return reloadById(prjId);
  }

  Future<Project> addCustomScopeItem(int prjId, secID, num qty, String name, msr) async {
    await post("/api/orgs/${Account.current.orgId}/projects/$prjId/custom-scope-items",
      headers: authHeader,
      body: {'sectionId': secID, 'quantity': qty, 'name': name, 'measure': msr});
    return reloadById(prjId);
  }

  Future<Project> removeScopeItem(int prjId, itemId) async {
    await delete("/api/orgs/${Account.current.orgId}/projects/$prjId/scope-items/$itemId",
      headers: authHeader);
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
