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
    return Account.fromJson(json.decode(data));
  }

  void storeSession(Account a) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString(accountStoreKey, json.encode(a.toJson()));
  }

  void deleteSession() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.remove(accountStoreKey);
  }
}
