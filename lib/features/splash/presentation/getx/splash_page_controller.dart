import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:party_app/global/routes/route_names.dart';

class SplashPageController extends GetxController {
  final GetStorage _storage = GetStorage();

  SplashPageController() {
    _hasSignupAttempt();
  }

  _hasSignupAttempt() async {
    await Future.delayed(Duration(seconds: 3));

    final user = _storage.read<String>("username");

    if (user == null || user.isEmpty) return Get.offNamed(RouteNames.LANDING);
    return Get.offNamed(RouteNames.PIN, arguments: user);
  }
}
