import 'package:party_app/features/profile/domain/entities/edit_profile.dart';

class UpdateProfileRequest {
  static Map<String, dynamic> toMap(EditProfile profile) =>
      {"name": profile.name, "thought": profile.thought};
}
