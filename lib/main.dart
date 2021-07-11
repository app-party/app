import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:party_app/global/routes/route_names.dart';

import 'global/routes/route_pages.dart';

void main() async {
  await GetStorage.init();

  runApp(PartyApp());
}

class PartyApp extends StatelessWidget {
  final black = Color(0xFF111111);

  PartyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: RoutePages.pagesRoute,
      initialRoute: RouteNames.SPLASH,
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: black,
        ),
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 12,
            fontFamily: "nunito",
            color: black,
          ),
          headline2: TextStyle(
            fontSize: 14,
            fontFamily: "nunito",
            color: black,
          ),
          headline3: TextStyle(
            fontSize: 16,
            fontFamily: "roboto",
            color: black.withOpacity(.8),
          ),
          headline6: TextStyle(
            fontSize: 24,
            fontFamily: "comfortaa",
            letterSpacing: 3,
          ),
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
