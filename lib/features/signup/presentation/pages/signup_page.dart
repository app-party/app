import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:party_app/features/signup/presentation/getx/signup_page_controller.dart';
import 'package:party_app/global/api/api.dart';
import 'package:party_app/global/widgets/gradient_button.dart';
import 'package:party_app/global/widgets/spacing.dart';

class SignupPage extends StatelessWidget {
  final _controller = Get.put(SignupPageController());
  final _form = GlobalKey<FormState>();

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
              key: _form,
              child: Column(
                children: [
                  TextFormField(
                    controller: _controller.username,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "E-mail",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return "O campo e-mail não pode estar vazio";
                      else if (!value.isEmail)
                        return "O campo precisa ser um e-mail válido";
                      return null;
                    },
                  ),
                  Spacing.hn,
                  Obx(
                    () => TextFormField(
                      controller: _controller.password,
                      obscureText: !_controller.isPasswordVisible.value,
                      decoration: InputDecoration(
                        hintText: "Senha",
                        suffixIcon: IconButton(
                          onPressed: _controller.changePasswordVisibility,
                          icon: Icon(
                            _controller.isPasswordVisible.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Color(0xFF111111),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return "O campo senha não pode estar vazio";
                        else if (value != _controller.confirmPassword.text)
                          return "As senhas não coincidem";
                        else if (API.ISPROD && value.length < 6)
                          return "A senha deve conter 6 caracteres ou mais";
                        return null;
                      },
                    ),
                  ),
                  Spacing.hn,
                  Obx(
                    () => TextFormField(
                      controller: _controller.confirmPassword,
                      obscureText: !_controller.isConfirmPasswordVisible.value,
                      decoration: InputDecoration(
                        hintText: "Confirmar senha",
                        suffixIcon: IconButton(
                          onPressed:
                              _controller.changeConfirmPasswordVisibility,
                          icon: Icon(
                            _controller.isConfirmPasswordVisible.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Color(0xFF111111),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return "O campo confirmar senha não pode estar vazio";
                        else if (value != _controller.password.text) {
                          print(value);
                          print(_controller.password.text);
                          return "As senhas não coincidem";
                        }
                        return null;
                      },
                    ),
                  ),
                  Spacing.hb,
                  Container(
                    height: 75,
                    child: GradientButton(
                      text: "CONCLUIR",
                      fn: () {
                        if (_form.currentState!.validate())
                          _controller.create();
                        // Get.to(PinPage());
                      },
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
