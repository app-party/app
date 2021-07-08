import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:party_app/features/signup/presentation/getx/signup_page_controller.dart';
import 'package:party_app/global/widgets/gradient_button.dart';

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
              style: TextStyle(
                  fontSize: 24, fontFamily: "comfortaa", letterSpacing: 3),
            ),
            SizedBox(
              height: 32,
            ),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "E-mail",
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
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
                  SizedBox(
                    height: 32,
                  ),
                  Container(
                    height: 75,
                    child: GradientButton(
                      text: "CONCLUIR",
                      fn: () {},
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
