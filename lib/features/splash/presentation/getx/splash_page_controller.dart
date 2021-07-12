import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:party_app/global/routes/route_names.dart';

class SplashPageController extends GetxController {
  final GetStorage _storage = GetStorage();

  SplashPageController() {
    _alreadySignedIn();
  }

  _alreadySignedIn() async {
    await Future.delayed(Duration(seconds: 2));

    final token = _storage.read<String>("accessToken");

    if (token == null || token.isEmpty) return _hasSignupAttempt();

    Get.offNamed(RouteNames.HOME);
  }

  _hasSignupAttempt() {
    final user = _storage.read<String>("username");

    if (user == null || user.isEmpty) return Get.offNamed(RouteNames.LANDING);
    return Get.offNamed(RouteNames.PIN, arguments: user);
  }
}
