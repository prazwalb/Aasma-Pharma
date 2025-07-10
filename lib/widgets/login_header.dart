
import 'package:flutter/material.dart';
import 'package:medilink/utils/constants/image_strings.dart';
import 'package:medilink/utils/constants/sizes.dart';
import 'package:medilink/utils/constants/text_strings.dart';

class Login_Header extends StatelessWidget {
  const Login_Header({super.key});

  @override
  Widget build(BuildContext context) {
   
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: PSizes.logoSize,
          child: Image(
            image: AssetImage(PImage.lightAppLogo ),
            fit: BoxFit.scaleDown,
          ),
        ),
        const SizedBox(height: PSizes.spaceBtwItems),
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
