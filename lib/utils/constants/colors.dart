import 'package:flutter/material.dart';

class PColors {
  PColors._();

  // App Basic Color
  static const Color primaryColor = Color(0xff4b68ff);
  static const Color secondaryColor = Color(0xffAAC4FF);
  static const Color accent = Color(0xffb0c7ff);

  //gradient colors
  static const Gradient linearGradient = LinearGradient(
    begin: Alignment(0, 0),
    end: Alignment(0.77, -0.70),
    colors: [Color(0xffff9a9e), Color(0xfffad0c4), Color(0xfffad0c4)],
  );

  //text color
  static const Color textPrimary = Color(0xff333333);
  static const Color textSecondary = Color(0xff6c7570);
  static const Color textWhite = Colors.white;

  //background color
  static const Color light = Color(0xffF6F6F6);
  static const Color dark = Color(0xff272727);
  static const Color primaryBackground = Color(0xfff3f5ff);

  //backgroun container colors
  static const Color lightContainer = Color(0xffF7F7F7);
  static Color darkContainer = PColors.textWhite.withOpacity(0.1);

  //button colors
  static const Color buttonPrimary = Color(0xff4b68ff);
  static const Color buttonSecondary = Color(0xff6c7570);
  static const Color buttonDisabled = Color(0xffc4c4c4);

  //border colors
  static const Color borderPrimary = Color(0xffd9d9d9);
  static const Color borderSecondary = Color(0xffe6e6e6);

  //error and validation color
  static const Color error = Color(0xffFF0000);
  static const Color success = Color(0xff388e3c);
  static const Color warning = Color(0xfff57c00);
  static const Color info = Color(0xff1976d2);

  // neutral sades
  static const Color black = Color(0xff232323);
  static const Color darkGrey = Color(0xff333333);
  static const Color grey = Color(0xffe0e0e0);
  static const Color darkerGrey = Color(0xff4f4f4f);
  static const Color softGrey = Color(0xfff4f4f4);
  static const Color lightGrey = Color(0xfff9f9f9);
  static const Color white = Color(0xffffffff);
}
