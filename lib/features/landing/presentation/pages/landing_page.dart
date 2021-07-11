import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:party_app/global/routes/route_names.dart';
import 'package:party_app/global/widgets/gradient_button.dart';
import 'package:party_app/global/widgets/spacing.dart';

class LandingPage extends StatelessWidget {
  LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/bg.jpeg"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5), BlendMode.dstATop)),
            ),
            child: Center(
              child: Image(image: AssetImage("assets/images/logo.png")),
            ),
          ),
          bottomBar()
        ],
      ),
    );
  }

  Container bottomBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      height: 75,
      child: Row(
        children: [
          Flexible(
            child: FractionallySizedBox(
              widthFactor: 1,
              child: GradientButton(
                text: "ENTRAR",
                fn: () => Get.toNamed(RouteNames.LOGIN),
              ),
            ),
          ),
          Spacing.wn,
          Flexible(
            child: FractionallySizedBox(
              widthFactor: 1,
              child: GradientButton(
                text: "REGISTRE-SE",
                pattern: GradientPatterns.pink,
                fn: () => Get.toNamed(RouteNames.SIGNUP),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
