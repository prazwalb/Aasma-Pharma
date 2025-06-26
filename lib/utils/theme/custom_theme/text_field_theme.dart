import 'package:flutter/material.dart';

class PTextFormFieldTheme {
  PTextFormFieldTheme._();

  //customizable light textformfield theme
  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,

    // constraints: BoxConstraints.expand(height: 14)
    labelStyle: TextStyle().copyWith(color: Colors.black, fontSize: 14),
    hintStyle: TextStyle().copyWith(color: Colors.black, fontSize: 14),
    errorStyle: TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: TextStyle().copyWith(
      color: Colors.black.withOpacity(0.8),
    ),
    border: OutlineInputBorder().copyWith(
      borderSide: BorderSide(color: Colors.grey, width: 0.5),
      borderRadius: BorderRadius.circular(14),
    ),
    enabledBorder: OutlineInputBorder().copyWith(
      borderSide: BorderSide(color: Colors.grey, width: 0.5),
      borderRadius: BorderRadius.circular(14),
    ),
    focusedBorder: OutlineInputBorder().copyWith(
      borderSide: BorderSide(color: Colors.black12, width: 0.5),
      borderRadius: BorderRadius.circular(14),
    ),
    errorBorder: OutlineInputBorder().copyWith(
      borderSide: BorderSide(color: Colors.red, width: 0.5),
      borderRadius: BorderRadius.circular(14),
    ),
    focusedErrorBorder: OutlineInputBorder().copyWith(
      borderSide: BorderSide(color: Colors.orange, width: 0.5),
      borderRadius: BorderRadius.circular(14),
    ),
  );

  //customizable dark textformfield theme
  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,

    // constraints: BoxConstraints.expand(height: 14)
    labelStyle: TextStyle().copyWith(color: Colors.white, fontSize: 14),
    hintStyle: TextStyle().copyWith(color: Colors.white, fontSize: 14),
    errorStyle: TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: TextStyle().copyWith(
      color: Colors.white.withOpacity(0.8),
    ),
    border: OutlineInputBorder().copyWith(
      borderSide: BorderSide(color: Colors.grey, width: 0.5),
      borderRadius: BorderRadius.circular(14),
    ),
    enabledBorder: OutlineInputBorder().copyWith(
      borderSide: BorderSide(color: Colors.grey, width: 0.5),
      borderRadius: BorderRadius.circular(14),
    ),
    focusedBorder: OutlineInputBorder().copyWith(
      borderSide: BorderSide(color: Colors.white, width: 0.5),
      borderRadius: BorderRadius.circular(14),
    ),
    errorBorder: OutlineInputBorder().copyWith(
      borderSide: BorderSide(color: Colors.red, width: 0.5),
      borderRadius: BorderRadius.circular(14),
    ),
    focusedErrorBorder: OutlineInputBorder().copyWith(
      borderSide: BorderSide(color: Colors.orange, width: 0.5),
      borderRadius: BorderRadius.circular(14),
    ),
  );
}
