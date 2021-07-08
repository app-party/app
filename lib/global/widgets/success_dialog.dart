import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:party_app/features/login/presentation/pages/login_page.dart';
import 'package:party_app/global/widgets/gradient_button.dart';
import 'package:party_app/global/widgets/spacing.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: Get.width / 2,
        padding: EdgeInsets.all(Spacing.tiny),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Icon(
                Icons.done,
                size: 70,
                color: Colors.green,
              ),
              Text(
                "Conta validada com sucesso!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF111111),
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  decoration: TextDecoration.none,
                ),
              ),
              Spacing.hb,
              GradientButton(
                text: "CONTINUAR",
                fn: () => Get.to(LoginPage()),
                pattern: GradientPatterns.blue,
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}
