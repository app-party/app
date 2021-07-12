import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:party_app/features/signup/adapters/singup_repository_adapter.dart';
import 'package:party_app/features/signup/domain/entities/pin_code.dart';
import 'package:party_app/features/signup/usecases/enable_user_us.dart';
import 'package:party_app/global/widgets/dialog_library.dart';

class PinPageController extends GetxController {
  final EnableUserUS _enableUserUS = EnableUserUS(SignupRepositoryAdapter());
  final GetStorage _storage = GetStorage();

  final TextEditingController pinController = TextEditingController();

  String username = Get.arguments;

  enableUser() async {
    DialogLibrary.staticLoading;

    final response = await _enableUserUS(
        PinCode(token: pinController.text.trim(), username: username));

    if (response.isLeft()) {
      Get.back();
      DialogLibrary.error((response as Left).value.message);
      return;
    }

    await _storage.remove("username");

    Get.back();

    DialogLibrary.userEnabled;
  }
}
