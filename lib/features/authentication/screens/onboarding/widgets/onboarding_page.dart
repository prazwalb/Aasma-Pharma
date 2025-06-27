import 'package:android_std/utils/constants/sizes.dart';
import 'package:android_std/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.all(PSizes.defaultSpace + 10),
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
