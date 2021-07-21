import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:party_app/features/profile/adapters/profile_repository_adapter.dart';
import 'package:party_app/features/profile/domain/entities/edit_profile.dart';
import 'package:party_app/features/profile/domain/entities/profile.dart';
import 'package:party_app/features/profile/usecases/update_profile_us.dart';
import 'package:party_app/global/widgets/dialog_library.dart';

class EditProfileController extends GetxController {
  final UpdateProfileUS _updateProfileUS =
      UpdateProfileUS(ProfileRepositoryAdapter());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController thoughtController = TextEditingController();

  final Profile profile;

  EditProfileController() : profile = Get.arguments {
    nameController.text = profile.name ?? "";
    thoughtController.text = profile.thought ?? "";
  }

  updateProfile() async {
    print("entrou");
    DialogLibrary.staticLoading;
    final response = await _updateProfileUS(EditProfile(
      name: nameController.text.trim(),
      thought: thoughtController.text.trim(),
    ));

    Get.back();

    if (response.isLeft()) {
      return DialogLibrary.error((response as Left).value.message);
    }

    await DialogLibrary.success;
    Get.back(result: true);
  }
}
