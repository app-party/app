import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:party_app/global/widgets/gradient_button.dart';
import 'package:party_app/global/widgets/spacing.dart';
import 'package:party_app/global/widgets/success_dialog.dart';
import 'package:pinput/pin_put/pin_put.dart';

class PinPage extends StatelessWidget {
  const PinPage({Key? key}) : super(key: key);

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Color(0xFF111111), width: 3),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Validar conta",
              style: TextStyle(
                  fontSize: 24, fontFamily: "comfortaa", letterSpacing: 3),
            ),
            Spacing.ht,
            Text(
              "Te enviamos um e-mail com um código de verificação, valide-o abaixo para acessar a plataforma.",
              style: TextStyle(fontSize: 16, fontFamily: "comfortaa"),
            ),
            Spacing.hb,
            PinPut(
              fieldsCount: 6,
              submittedFieldDecoration: _pinPutDecoration.copyWith(
                border: Border.all(width: 2),
              ),
              selectedFieldDecoration: _pinPutDecoration,
              followingFieldDecoration: _pinPutDecoration.copyWith(
                border: Border.all(width: 2),
              ),
              inputDecoration: InputDecoration(
                enabledBorder: InputBorder.none,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                counter: Container(),
              ),
            ),
            Spacing.hb,
            GradientButton(
              text: "VALIDAR",
              fn: () => Get.dialog(SuccessDialog()),
              pattern: GradientPatterns.pink,
            )
          ],
        ),
      ),
    );
  }
}
