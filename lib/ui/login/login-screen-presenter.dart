import 'package:add_just/models/user.dart';
import 'package:add_just/services/api/base.dart';
import 'package:add_just/services/api/login.dart';
import 'package:add_just/services/prefs.dart';

abstract class LoginContract {
  void onLoginCodeRequested(String email);
  void onLoginSuccess(User user);
  void onLoginError(String errorTxt);
}

class LoginScreenPresenter {
  LoginContract _view;
  Login _loginService = new Login();
  LoginScreenPresenter(this._view);

  void requestCode(String email) async {
    try {
      await _loginService.requestCode(email);
      _view.onLoginCodeRequested(email);
    } catch (e) {
      _handleError(e);
    }
  }

  void doLogin(String email, code) async {
    try {
      ApiResponse resp = await _loginService.requestToken(email, code);
      User user = User.fromApiResponse(resp);
      PrefsService prefs = new PrefsService();
      prefs.storeUser(user);
      _view.onLoginSuccess(user);
    } catch (e) {
      _handleError(e);
    }
  }

  void _handleError(Exception error) {
    _view.onLoginError(error.toString());
  }
}
