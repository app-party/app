import 'package:get/get.dart';

class LoginPageController extends GetxController {
  RxBool isVisible = false.obs;

  change() => isVisible.value = !isVisible.value;
}
