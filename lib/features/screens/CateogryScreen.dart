import 'package:android_std/common/widgets/custom_appbar/appbar.dart';
import 'package:flutter/material.dart';

class Cateogryscreen extends StatelessWidget {
  const Cateogryscreen({super.key});

  @override
  Widget build(BuildContext context) {
  
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      appBar: PAppbar(actions: [],),
      
    ));
  }
}