import 'package:android_std/features/authentication/screens/onboarding/onboarding.dart';
import 'package:android_std/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

///------ use this class to setup thtemes,initialize Binding, any animation and much more
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: PAppTheme.lightTheme,
      darkTheme: PAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
    );
  }
}
