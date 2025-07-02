import 'package:android_std/common/widgets/custom_appbar/appbar.dart';
import 'package:android_std/common/widgets/custom_shapes/container/primary_header_container.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///-header
            PrimaryHeaderContainer(
              child:Column(
                children: [
                  PAppbar(actions: [])
                  
                ],
              )
              )
          ],
        ),
      ),
    );
}
}