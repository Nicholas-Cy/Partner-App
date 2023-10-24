import 'package:flutter/material.dart';

enum AppTheme { lightTheme, darkTheme }

final appThemeData = {
  AppTheme.lightTheme: ThemeData(
    primaryColor: Colors.black,
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.blue,
    ),
    backgroundColor: const Color.fromRGBO(248, 248, 248, 1.0),
    scaffoldBackgroundColor: const Color.fromRGBO(248, 248, 248, 1.0),
  ),
  AppTheme.darkTheme: ThemeData(
    primaryColor: Colors.white,
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.white,
    ),
    backgroundColor: const Color.fromARGB(255, 80, 80, 80),
    scaffoldBackgroundColor: const Color.fromARGB(255, 80, 80, 80),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.black.withOpacity(0),
    ),
  )
};
