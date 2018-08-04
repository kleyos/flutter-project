import 'package:add_just/models/user.dart';
import 'package:add_just/services/api/base.dart';
import 'package:add_just/services/api/login.dart';

abstract class LoginContract {
  void onLoginCodeRequested(String email);
  void onLoginSuccess(User user);
  void onLoginError(String errorTxt);
}

class LoginScreenPresenter {
  LoginContract _view;
  Login loginService = new Login(baseURL: 'https://api.staging.termpay.io/api');
  LoginScreenPresenter(this._view);

  void requestCode(String email) {
    loginService.requestCode(email).then((_) {
      _view.onLoginCodeRequested(email);
    }).catchError((Exception error) => _view.onLoginError(error.toString()));
  }

  void doLogin(String email, code) {
    loginService.requestToken(email, code).then((ApiResponse resp) {
      _view.onLoginSuccess(User.fromApiResponse(resp));
    }).catchError((Exception error) => _view.onLoginError(error.toString()));
  }
}
