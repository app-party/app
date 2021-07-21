import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:party_app/features/profile/domain/entities/profile.dart';

class EditProfileController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController thoughtController = TextEditingController();

  final Profile profile;

  EditProfileController() : profile = Get.arguments {
    nameController.text = profile.name ?? "";
    thoughtController.text = profile.thought ?? "";
  }
}
