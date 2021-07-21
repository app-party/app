import 'package:party_app/features/profile/domain/entities/profile.dart';
import 'package:party_app/features/profile/domain/entities/profile_image.dart';

class GetProfileResponse {
  static Profile toProfile(Map<String, dynamic> m) => Profile(
        name: m["name"],
        images: m["photos"]
            .map<ProfileImage>(
              (img) => ProfileImage(
                contentType: img["contentType"],
                url: img["url"],
              ),
            )
            .toList(),
        thought: m["thought"],
      );
}
