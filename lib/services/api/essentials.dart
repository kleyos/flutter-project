import 'dart:async';
import 'dart:io';
import 'package:add_just/models/account.dart';
import 'package:add_just/models/boq-item.dart';
import 'package:add_just/services/api/base.dart';

class Essentials extends Base {
  Essentials({
    String host
  }) : super(host: host);

  Future<List<BoqItem>> loadBoqItems(Account acc) async {
    ApiResponse resp = await get("/api/orgs/${acc.orgId}/boq-items",
      headers: {HttpHeaders.authorizationHeader: "Bearer ${acc.accessToken}"});
    if (resp.data == null || List.from(resp.data['boqItems']).isEmpty) {
      return [];
    }
    return List.from(resp.data['boqItems']).map((p) => BoqItem.fromApiResponse(p)).toList();
  }
}
