import 'package:android_std/utils/theme/theme.dart';
import 'package:flutter/material.dart';


///------ use this class to setup thtemes,initialize Binding, any animation and much more
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: PAppTheme.lightTheme,
      darkTheme: PAppTheme.darkTheme,
    );
  }
}
