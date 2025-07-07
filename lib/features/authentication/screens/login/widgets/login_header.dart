import 'package:android_std/utils/constants/image_strings.dart';
import 'package:android_std/utils/constants/sizes.dart';
import 'package:android_std/utils/constants/text_strings.dart';
import 'package:android_std/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';

class Login_Header extends StatelessWidget {
  const Login_Header({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = PHelperFunction.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: PSizes.logoSize,
          child: Image(
            image: AssetImage(dark ? PImage.lightAppLogo : PImage.darkAppLogo),
            fit: BoxFit.scaleDown,
          ),
        ),
        SizedBox(height: PSizes.spaceBtwItems),
        Text(
          PTexts.loginTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        SizedBox(height: PSizes.sm),
        Text(
          PTexts.loginSubTitle,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
