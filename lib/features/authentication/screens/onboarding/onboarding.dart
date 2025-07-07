import 'package:android_std/features/controllers/onbaording_controller.dart';
import 'package:android_std/features/authentication/screens/onboarding/widgets/onboarding_nextbutton.dart';
import 'package:android_std/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:android_std/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:android_std/features/authentication/screens/onboarding/widgets/onboardingdot_navigation.dart';
import 'package:android_std/utils/constants/image_strings.dart';
import 'package:android_std/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    return Scaffold(
      body: Stack(
        children: [
          //horizontall scorllabel page
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: [
              OnBoardingPage(
                image: PImage.onBoardingImage1,
                title: PTexts.onBoardingTitle1,
                subtitle: PTexts.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                image: PImage.onBoardingImage2,
                title: PTexts.onBoardingTitle2,
                subtitle: PTexts.onBoardingSubTitle2,
              ),
              OnBoardingPage(
                image: PImage.onBoardingImage3,
                title: PTexts.onBoardingTitle3,
                subtitle: PTexts.onBoardingSubTitle3,
              ),
            ],
          ),

          //skip button
          OnBoardingSkip(),

          //dot navigatioin SmoothPage indicator
          OnBoardingNavigation(),

          //circular button
          OnBoardingNextButton(),
        ],
      ),
    );
  }
}
