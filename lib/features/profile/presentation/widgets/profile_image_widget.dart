import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:party_app/features/profile/domain/entities/profile_image.dart';
import 'package:party_app/global/extensions/string_initials.dart';

class ProfileImageWidget extends StatelessWidget {
  final ProfileImage? image;
  final String? name;

  ProfileImageWidget({Key? key, this.image, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (image == null || image!.url.isEmpty)
      return Container(
        width: 128,
        height: 128,
        decoration: BoxDecoration(
          color: Color(0xFF111111),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
            child: Text(
          name != null ? name!.initials() : "",
          style: Get.textTheme.headline6!.copyWith(
            color: Colors.white,
          ),
        )),
      );
    return CircleAvatar(
      backgroundImage: NetworkImage(image!.url),
      radius: 64,
    );
  }
}
