import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:party_app/features/splash/presentation/getx/splash_page_controller.dart';

class SplashPage extends StatelessWidget {
  SplashPage({Key? key}) : super(key: key) {
    Get.put(SplashPageController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
