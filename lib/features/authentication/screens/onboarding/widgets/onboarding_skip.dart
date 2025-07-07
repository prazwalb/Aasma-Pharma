import 'package:android_std/features/controllers/onbaording_controller.dart';
import 'package:android_std/utils/constants/sizes.dart';
import 'package:android_std/utils/device/device_utility.dart';
import 'package:flutter/material.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: PDeviceUtils.getAppBarHeight(),
      right: PSizes.defaultSpace,
      child: TextButton(
        onPressed: () {
          OnBoardingController.instance.skipPage();
        },
        child: Text('Skip', style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
