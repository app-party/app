import 'package:get/get.dart';

class SignupPageController extends GetxController {
  RxBool isVisible = false.obs;

  change() => isVisible.value = !isVisible.value;
}
