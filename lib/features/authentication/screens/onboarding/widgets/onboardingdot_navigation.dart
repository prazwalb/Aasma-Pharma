import 'package:android_std/features/controllers/onbaording_controller.dart';
import 'package:android_std/utils/constants/colors.dart';
import 'package:android_std/utils/constants/sizes.dart';
import 'package:android_std/utils/device/device_utility.dart';
import 'package:android_std/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingNavigation extends StatelessWidget {
  const OnBoardingNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = PHelperFunction.isDarkMode(context);
    final controller = OnBoardingController.instance;

    return Positioned(
      bottom: PDeviceUtils.getBottomNavigationBarHeigth() + 25,
      left: PSizes.defaultSpace,
      child: SmoothPageIndicator(
        controller: controller.pageController,
        onDotClicked: controller.dotNavigationClick,
        count: 3,
        effect: SlideEffect(activeDotColor: PColors.dark, dotHeight: 6),
      ),
    );
  }
}
