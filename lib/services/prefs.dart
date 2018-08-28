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
    return data != null ? Account.fromJson(json.decode(data)) : null;
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
