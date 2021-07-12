import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:party_app/features/login/adapters/login_repository_adapter.dart';
import 'package:party_app/features/login/domain/entities/login_user.dart';
import 'package:party_app/features/login/usecases/login_us.dart';
import 'package:party_app/global/api/api.dart';
import 'package:party_app/global/routes/route_names.dart';
import 'package:party_app/global/widgets/dialog_library.dart';

class LoginPageController extends GetxController {
  final LoginUS _loginUS = LoginUS(LoginRepositoryAdapter());
  final GetStorage _storage = GetStorage();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPageController() {
    if (!API.ISPROD) {
      usernameController.text = "feericles@gmail.com";
      passwordController.text = "1234";
    }
  }

  RxBool isVisible = false.obs;

  change() => isVisible.value = !isVisible.value;

  login() async {
    DialogLibrary.staticLoading;

    final response = await _loginUS(LoginUser(
      username: usernameController.text.trim(),
      password: passwordController.text.trim(),
    ));

    if (response.isLeft()) {
      Get.back();
      DialogLibrary.error((response as Left).value.message);
      return;
    }

    await _storage.write("accessToken", (response as Right).value);

    Get.back();

    Get.offAllNamed(RouteNames.HOME);
  }
}
