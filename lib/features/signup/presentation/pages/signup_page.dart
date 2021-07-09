import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:party_app/features/signup/presentation/getx/signup_page_controller.dart';
import 'package:party_app/features/signup/presentation/pages/pin_page.dart';
import 'package:party_app/global/widgets/gradient_button.dart';
import 'package:party_app/global/widgets/spacing.dart';

class SignupPage extends StatelessWidget {
  final _controller = Get.put(SignupPageController());

  SignupPage({Key? key}) : super(key: key);

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
              "Registre-se",
              style: Get.textTheme.headline6,
            ),
            Spacing.ht,
            Text(
              "Bem-vindo(a) ao Party App, cadastre-se e garanta acesso as melhores festas da sua região.",
              style: TextStyle(fontSize: 16, fontFamily: "comfortaa"),
            ),
            Spacing.hb,
            Form(
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "E-mail",
                    ),
                  ),
                  Spacing.hn,
                  Obx(
                    () => TextFormField(
                      obscureText: !_controller.isVisible.value,
                      decoration: InputDecoration(
                        hintText: "Senha",
                        suffixIcon: IconButton(
                            onPressed: _controller.change,
                            icon: Icon(
                              _controller.isVisible.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Color(0xFF111111),
                            )),
                      ),
                    ),
                  ),
                  Spacing.hb,
                  Container(
                    height: 75,
                    child: GradientButton(
                      text: "CONCLUIR",
                      fn: () => Get.to(PinPage()),
                      pattern: GradientPatterns.pink,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
