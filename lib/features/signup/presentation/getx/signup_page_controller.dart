import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:party_app/features/signup/adapters/singup_repository_adapter.dart';
import 'package:party_app/features/signup/domain/entities/signup_user.dart';
import 'package:party_app/features/signup/usecases/create_user_us.dart';
import 'package:party_app/global/routes/route_names.dart';
import 'package:party_app/global/widgets/dialog_library.dart';

class SignupPageController extends GetxController {
  final CreateUserUS _createUserUS = CreateUserUS(SignupRepositoryAdapter());
  final GetStorage _storage = GetStorage();

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  RxBool isPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;

  changePasswordVisibility() =>
      isPasswordVisible.value = !isPasswordVisible.value;
  changeConfirmPasswordVisibility() =>
      isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;

  create() async {
    DialogLibrary.staticLoading;

    final response = await _createUserUS(
      SignupUser(
        username: username.text.trim(),
        password: password.text.trim(),
        confirmPassword: confirmPassword.text.trim(),
      ),
    );

    if (response.isLeft()) {
      Get.back();
      DialogLibrary.error((response as Left).value.message);
      return;
    }

    await saveLocalData();

    Get.offNamed(RouteNames.PIN, arguments: username.text.trim());
  }

  Future saveLocalData() async =>
      await _storage.write("username", username.text.trim());
}
