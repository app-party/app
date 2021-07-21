import 'profile_image.dart';

class Profile {
  String? name;
  String? thought;
  List<ProfileImage>? images;

  Profile({this.images, this.name, this.thought});
}
