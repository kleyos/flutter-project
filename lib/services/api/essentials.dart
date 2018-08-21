import 'dart:async';
import 'dart:io';
import 'package:add_just/models/account.dart';
import 'package:add_just/models/boq-items-container.dart';
import 'package:add_just/services/api/base.dart';

class Essentials extends Base {
  Essentials({
    String host
  }) : super(host: host);

  Future<BoqItemsContainer> loadBoqItems() async {
    ApiResponse resp = await get("/api/orgs/${Account.current.orgId}/boq-items",
      headers: {HttpHeaders.authorizationHeader: "Bearer ${Account.current.accessToken}"});
    if (resp.data == null || List.from(resp.data['boqItems']).isEmpty) {
      return null;
    }
    return BoqItemsContainer.fromApiResponse(List.from(resp.data['boqItems']));
  }
}
