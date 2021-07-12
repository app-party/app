import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:party_app/global/routes/route_names.dart';
import 'package:party_app/global/widgets/spacing.dart';

import 'gradient_button.dart';

class DialogLibrary {
  static get staticLoading => Get.dialog(
        Center(
          child: SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(),
          ),
        ),
        barrierDismissible: false,
      );

  static error(List<String> messages) => Get.dialog(
        _defaultDialog(
          icon: Icon(
            Icons.close,
            size: 70,
            color: Colors.red,
          ),
          messages: messages,
          btnLabel: "VOLTAR",
          fn: () => Get.back(),
        ),
      );

  static get userEnabled => Get.dialog(
        _defaultDialog(
          icon: Icon(
            Icons.done,
            size: 70,
            color: Colors.green,
          ),
          messages: ["Conta validada com sucesso!"],
          btnLabel: "CONTINUAR",
          fn: () => Get.toNamed(RouteNames.LOGIN),
        ),
        // Center(
        //   child: Container(
        //     width: Get.width / 1.5,
        //     padding: EdgeInsets.all(Spacing.tiny),
        //     color: Colors.white,
        //     child: SingleChildScrollView(
        //       child: Column(
        //         children: [
        //           Icon(
        //             Icons.done,
        //             size: 70,
        //             color: Colors.green,
        //           ),
        //           Text(
        //             "Conta validada com sucesso!",
        //             textAlign: TextAlign.center,
        //             style: TextStyle(
        //               color: Color(0xFF111111),
        //               fontStyle: FontStyle.normal,
        //               fontWeight: FontWeight.w500,
        //               fontSize: 20,
        //               decoration: TextDecoration.none,
        //             ),
        //           ),
        //           Spacing.hb,
        //           GradientButton(
        //             text: "CONTINUAR",
        //             fn: () => Get.toNamed(RouteNames.LOGIN),
        //             pattern: GradientPatterns.blue,
        //             height: 40,
        //           )
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        barrierDismissible: false,
      );

  static Widget _defaultDialog(
      {required Icon icon,
      required List<String> messages,
      required String btnLabel,
      required VoidCallback fn}) {
    return Center(
      child: Container(
        width: Get.width / 1.5,
        padding: EdgeInsets.all(Spacing.tiny),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              icon,
              Column(
                children: messages
                    .map<Widget>(
                      (message) => Text(
                        message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF111111),
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    )
                    .toList(),
              ),
              Spacing.hb,
              GradientButton(
                text: btnLabel,
                fn: fn,
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
