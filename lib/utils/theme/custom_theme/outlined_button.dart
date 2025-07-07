import 'package:flutter/material.dart';

class POutlinedButtonTheme {
  POutlinedButtonTheme._();

  ///--light theme
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.black, //color of hte text
      side: BorderSide(color: Colors.purple.shade100), //boarder
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      textStyle: TextStyle(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
  );

  ///--dark theme
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white, //color of hte text
      side: BorderSide(color: Colors.purple.shade100), //boarder
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      textStyle: TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
  );
}
