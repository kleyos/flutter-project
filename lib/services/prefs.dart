import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:add_just/models/account.dart';

class PrefsService {
  static final PrefsService _instance = new PrefsService._internal();
  static final accountStoreKey = 'account';

  PrefsService._internal();

  factory PrefsService() {
    return _instance;
  }

  Future<Account> restoreSession() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String data = await _prefs.get(accountStoreKey);
//    return data != null ? Account.fromJson(json.decode(data)) : null;
    // AMO
     return new Account(accessToken: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJlbWFpbCI6ImFtbzFAbWtlbGx5Y2xhcmUuMzNtYWlsLmNvbSIsInJvbGUiOiJhbW8iLCJoYXNoIjoiMWZjOTQwNTgtZTQ5Yi00NzRiLWFiMzEtMWVlMjgyZWZmYzRhIiwib3JnX2lkIjoxLCJhdWQiOiJwb3N0Z3JhcGhpbGUiLCJpYXQiOjE1MzI5Njg2MzAsImV4cCI6MTU5NjA4MzgzMH0.C9BIGdYHTmer2uyoRp3D6BnlyKE8vt9gAkFfx3_T4KE', role: 'amo', orgId: 1);
    // CTR
//    return new Account(accessToken: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxMCwiZW1haWwiOiJjdHIxQG1rZWxseWNsYXJlLjMzbWFpbC5jb20iLCJyb2xlIjoiY3RyIiwiaGFzaCI6IjBmNGZmZGM3LTQyNTUtNDlmNC04ODEwLWNhMzJiZGIzYzc1ZCIsIm9yZ19pZCI6MSwiYXVkIjoicG9zdGdyYXBoaWxlIiwiaWF0IjoxNTM0OTMxMDQ3LCJleHAiOjE1MzYxNDA2NDd9.5KSBza51k9CuwxAj8EAMRlfqGDyqEMas_FlP0egTQbk', role: 'ctr', orgId: 1);
  }

  Future<bool> storeSession(Account a) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return await _prefs.setString(accountStoreKey, json.encode(a.toJson()));
  }

  Future<bool> deleteSession() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return await _prefs.remove(accountStoreKey);
  }
}
