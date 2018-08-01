import 'package:meta/meta.dart';

class User {
  User({
    @required this.email,
    this.accessToken
  });

  final String email;
  final String accessToken;

  bool isAuthenticated() => accessToken.isNotEmpty;
}
