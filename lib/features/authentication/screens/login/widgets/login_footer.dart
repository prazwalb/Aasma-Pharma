import 'package:android_std/utils/constants/colors.dart';
import 'package:android_std/utils/constants/image_strings.dart';
import 'package:android_std/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: PColors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
              image: AssetImage(PImage.google),
              height: PSizes.iconMd,
              width: PSizes.iconMd,
            ),
          ),
        ),
        const SizedBox(width: PSizes.spaceBtwItems),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: PColors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
              image: AssetImage(PImage.facebook),
              height: PSizes.iconMd,
              width: PSizes.iconMd,
            ),
          ),
        ),
      ],
    );
  }
}
