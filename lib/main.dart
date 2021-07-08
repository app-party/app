import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:party_app/features/landing/presentation/pages/landing_page.dart';

void main() {
  runApp(PartyApp());
}

class PartyApp extends StatelessWidget {
  final black = Color(0xFF111111);

  PartyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: LandingPage(),
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: black,
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: black, width: 1),
            borderRadius: BorderRadius.zero,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: black, width: 1),
            borderRadius: BorderRadius.zero,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: black, width: 2),
            borderRadius: BorderRadius.zero,
          ),
          suffixStyle: TextStyle(color: black),
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: black,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0)),
            textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            )),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
          ),
        ),
      ),
    );
  }
}
