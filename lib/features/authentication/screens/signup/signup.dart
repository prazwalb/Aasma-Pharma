import 'package:android_std/common/widgets/login_signup/form_divider.dart';
import 'package:android_std/common/widgets/login_signup/social_button.dart';
import 'package:android_std/features/authentication/screens/signup/widget/signup_form.dart';
import 'package:android_std/utils/constants/sizes.dart';
import 'package:android_std/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(PSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// title
              Text(
                PTexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: PSizes.spaceBtwSections),

              // Form
              SignupForm(),
              SizedBox(height: PSizes.spaceBtwSections),

              //divider
              FormDivider(dividerText: PTexts.orSignUpWith.capitalize!),

              SizedBox(height: PSizes.spaceBtwSections),

              //social button
              SocialButton(),
            ],
          ),
        ),
      ),
    );
  }
}
