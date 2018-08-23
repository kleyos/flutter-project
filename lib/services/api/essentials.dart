import 'dart:async';
import 'dart:io';
import 'package:add_just/models/account.dart';
import 'package:add_just/models/boq-items-container.dart';
import 'package:add_just/services/api/base.dart';

class Essentials extends Base {
  static final Essentials _singleton = Essentials._internal();

  factory Essentials() {
    return _singleton;
  }

  Essentials._internal();

  BoqItemsContainer _boqItemsContainer;

  Future<BoqItemsContainer> loadBoqItems() async {
    if (_boqItemsContainer != null) {
      return _boqItemsContainer;
    }
    ApiResponse resp = await get("/api/orgs/${Account.current.orgId}/boq-items",
      headers: {HttpHeaders.authorizationHeader: "Bearer ${Account.current.accessToken}"});
    if (resp.data == null || List.from(resp.data['boqItems']).isEmpty) {
      return null;
    }
    _boqItemsContainer = BoqItemsContainer.fromApiResponse(List.from(resp.data['boqItems']));
    return _boqItemsContainer;
  }
}
