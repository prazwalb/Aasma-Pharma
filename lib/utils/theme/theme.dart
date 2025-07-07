import 'package:android_std/utils/theme/custom_theme/app_bar_theme.dart';
import 'package:android_std/utils/theme/custom_theme/bottom_sheet_theme.dart';
import 'package:android_std/utils/theme/custom_theme/checkbox_theme.dart';
import 'package:android_std/utils/theme/custom_theme/chip_theme.dart';
import 'package:android_std/utils/theme/custom_theme/elevated_buttom_theme.dart';
import 'package:android_std/utils/theme/custom_theme/outlined_button.dart';
import 'package:android_std/utils/theme/custom_theme/text_field_theme.dart';
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
    elevatedButtonTheme: PElevatedButton.lightElevatedButtonTheme,
    appBarTheme: PAppBarTheme.lightAppBarTheme,
    checkboxTheme: PCheckBoxTheme.lightCheckboxTheme,
    bottomSheetTheme: PBottomSheetTheme.lightBottomSheetTheme,
    outlinedButtonTheme: POutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: PTextFormFieldTheme.lightInputDecorationTheme,
    chipTheme: PChipTheme.lightChipTheme,
    // bottomSheetTheme:
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poopins',
    brightness: Brightness.dark,
    primaryColor: Colors.deepPurpleAccent,
    scaffoldBackgroundColor: Colors.black,
    textTheme: PTextTheme.darkText,
    elevatedButtonTheme: PElevatedButton.darkElevatedButtonTheme,
    appBarTheme: PAppBarTheme.dakAppBarTheme,
    checkboxTheme: PCheckBoxTheme.darkCheckboxTheme,
    bottomSheetTheme: PBottomSheetTheme.darkBottomSheetTheme,
    outlinedButtonTheme: POutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: PTextFormFieldTheme.darkInputDecorationTheme,
    chipTheme: PChipTheme.darkChipTheme,
  );
}

//--method
/* ThemeData(
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize:14,color: Colors.green)
        )
      ), */
