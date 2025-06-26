import 'package:android_std/utils/constants/colors.dart';
import 'package:android_std/utils/constants/image_strings.dart';
import 'package:android_std/utils/constants/sizes.dart';
import 'package:android_std/utils/constants/text_strings.dart';
import 'package:android_std/utils/device/device_utility.dart';
import 'package:android_std/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //horizontall scorllabel page
          PageView(
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

          OnBoardingNavigation(),
        ],
      ),
    );
  }
}

class OnBoardingNavigation extends StatelessWidget {
  const OnBoardingNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = PHelperFunction.isDarkMode(context);

    return Positioned(
      bottom: PDeviceUtils.getBottomNavigationBarHeigth() + 25,
      left: PSizes.defaultSpace,
      child: SmoothPageIndicator(
        controller: PageController(),
        count: 3,
        effect: SlideEffect(activeDotColor: PColors.dark, dotHeight: 6),
      ),
    );
  }
}

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: PDeviceUtils.getAppBarHeight(),
      right: PSizes.defaultSpace,
      child: TextButton(onPressed: () {}, child: Text('Skip')),
    );
  }
}

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final String image, title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(PSizes.defaultSpace),
      child: Column(
        children: [
          Image(
            image: AssetImage(image),
            height: PHelperFunction.screenHeight() * 0.6,
            width: PHelperFunction.screenWidth() * 0.7,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: PSizes.spaceBtwItems),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
