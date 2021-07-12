import 'package:party_app/features/login/domain/entities/login_user.dart';

class LoginRequest {
  static Map<String, dynamic> toMap(LoginUser user) =>
      {"username": user.username, "password": user.password};
}
