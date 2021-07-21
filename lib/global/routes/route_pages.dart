import 'package:get/get.dart';
import 'package:party_app/features/home/presentation/pages/home_page.dart';
import 'package:party_app/features/landing/presentation/pages/landing_page.dart';
import 'package:party_app/features/login/presentation/pages/login_page.dart';
import 'package:party_app/features/profile/presentation/pages/profile_page.dart';
import 'package:party_app/features/signup/presentation/pages/pin_page.dart';
import 'package:party_app/features/signup/presentation/pages/signup_page.dart';
import 'package:party_app/features/splash/presentation/pages/splash_page.dart';
import 'package:party_app/global/routes/route_names.dart';

class RoutePages {
  static final List<GetPage> pagesRoute = [
    GetPage(name: RouteNames.LANDING, page: () => LandingPage()),
    GetPage(name: RouteNames.HOME, page: () => HomePage()),
    GetPage(name: RouteNames.LOGIN, page: () => LoginPage()),
    GetPage(name: RouteNames.PIN, page: () => PinPage()),
    GetPage(name: RouteNames.SIGNUP, page: () => SignupPage()),
    GetPage(name: RouteNames.SPLASH, page: () => SplashPage()),
    GetPage(name: RouteNames.PROFILE, page: () => ProfilePage()),
  ];
}
