import 'package:party_app/features/signup/domain/entities/signup_user.dart';

class CreateUserRequest {
  static Map<String, dynamic> toMap(SignupUser user) {
    return {
      "username": user.username,
      "password": user.password,
      "confirmPassword": user.confirmPassword,
    };
  }
}
