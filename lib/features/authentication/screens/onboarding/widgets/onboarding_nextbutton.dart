import 'package:android_std/features/controllers/onbaording_controller.dart';
import 'package:android_std/utils/constants/colors.dart';
import 'package:android_std/utils/constants/sizes.dart';
import 'package:android_std/utils/device/device_utility.dart';
import 'package:android_std/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = PHelperFunction.isDarkMode(context);
    return Positioned(
      right: PSizes.defaultSpace,
      bottom: PDeviceUtils.getBottomNavigationBarHeigth(),
      child: ElevatedButton(
        onPressed: () {
          OnBoardingController.instance.nextPage();
        },
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          backgroundColor: dark ? PColors.primaryColor : Colors.black,
        ),
        child: Icon(Icons.keyboard_arrow_right_outlined),
      ),
    );
  }
}
