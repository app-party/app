import 'package:party_app/features/signup/domain/entities/pin_code.dart';

class EnableUserRequest {
  static Map<String, dynamic> toMap(PinCode pin) => {
        "token": pin.token,
        "username": pin.username,
      };
}
