import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:party_app/features/login/presentation/getx/login_page_controller.dart';
import 'package:party_app/global/api/api.dart';
import 'package:party_app/global/widgets/gradient_button.dart';
import 'package:party_app/global/widgets/spacing.dart';

class LoginPage extends StatelessWidget {
  final _controller = Get.put(LoginPageController());
  final _form = GlobalKey<FormState>();

  LoginPage({Key? key}) : super(key: key);

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
              "Entrar",
              style: Get.textTheme.headline6,
            ),
            Spacing.ht,
            Text(
              "Bem-vindo(a), estávamos aguardando pela sua volta!",
              style: TextStyle(fontSize: 16, fontFamily: "comfortaa"),
            ),
            Spacing.hb,
            Form(
              key: _form,
              child: Column(
                children: [
                  TextFormField(
                    controller: _controller.usernameController,
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
                      controller: _controller.passwordController,
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
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return "O campo senha não pode estar vazio";
                        else if (API.ISPROD && value.length < 6)
                          return "A senha deve conter 6 caracteres ou mais";
                        return null;
                      },
                    ),
                  ),
                  Spacing.hb,
                  Container(
                    height: 75,
                    child: GradientButton(
                        text: "ENTRAR",
                        fn: () {
                          if (_form.currentState!.validate())
                            _controller.login();
                        }),
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
