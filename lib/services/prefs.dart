import 'package:shared_preferences/shared_preferences.dart';
import 'package:add_just/models/account.dart';

class PrefsService {
  static final PrefsService _instance = new PrefsService._internal();

  PrefsService._internal();

  factory PrefsService() {
    return _instance;
  }

  dynamic getValue(key) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.get(key);
  }

  void storeUser(Account user) {

  }
}
