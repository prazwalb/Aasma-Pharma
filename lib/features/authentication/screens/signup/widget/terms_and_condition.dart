import 'package:android_std/utils/constants/colors.dart';
import 'package:android_std/utils/constants/sizes.dart';
import 'package:android_std/utils/constants/text_strings.dart';
import 'package:android_std/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';

class TermsandConditionCheckbox extends StatelessWidget {
  const TermsandConditionCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = PHelperFunction.isDarkMode(context);
    return Row(
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: Checkbox(value: true, onChanged: (value) {}),
        ),
        SizedBox(width: PSizes.spaceBtwItems),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "${PTexts.iAgreeto} ",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              TextSpan(
                text: PTexts.privacyPolicy,
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: dark ? PColors.white : PColors.primaryColor,
                  decoration: TextDecoration.underline,
                  decorationColor: dark ? PColors.white : PColors.primaryColor,
                ),
              ),
              TextSpan(
                text: " and ",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              TextSpan(
                text: '${PTexts.termsAndCondition} ',
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: dark ? PColors.white : PColors.primaryColor,
                  decoration: TextDecoration.underline,
                  decorationColor: dark ? PColors.white : PColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
