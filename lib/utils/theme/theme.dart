import 'package:android_std/utils/theme/custom_theme/text_theme.dart';
import 'package:flutter/material.dart';

class PAppTheme {
  PAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poopins',
    brightness: Brightness.light,
    primaryColor: Colors.deepPurpleAccent,
    scaffoldBackgroundColor: Colors.white,
    textTheme: PTextTheme.lightText,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poopins',
    brightness: Brightness.dark,
    primaryColor: Colors.deepPurpleAccent,
    scaffoldBackgroundColor: Colors.black,
    textTheme: PTextTheme.darkText,
  );
}


/* ThemeData(
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize:14,color: Colors.green)
        )
      ), */