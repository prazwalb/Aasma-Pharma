import 'package:android_std/features/authentication/screens/signup/verify_email.dart';
import 'package:android_std/features/authentication/screens/signup/widget/terms_and_condition.dart';
import 'package:android_std/utils/constants/sizes.dart';
import 'package:android_std/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  expands: false,
                  decoration: InputDecoration(
                    labelText: PTexts.firstname,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
              SizedBox(width: PSizes.spaceBtwInputField),
              Expanded(
                child: TextFormField(
                  expands: false,
                  decoration: InputDecoration(
                    labelText: PTexts.lastname,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: PSizes.spaceBtwInputField),

          //username
          TextFormField(
            expands: false,
            decoration: InputDecoration(
              labelText: PTexts.username,
              prefixIcon: Icon(Iconsax.user_edit),
            ),
          ),
          SizedBox(height: PSizes.spaceBtwInputField),
          //email
          TextFormField(
            expands: false,
            decoration: InputDecoration(
              labelText: PTexts.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),
          SizedBox(height: PSizes.spaceBtwInputField),
          //phonr number
          TextFormField(
            expands: false,
            decoration: InputDecoration(
              labelText: PTexts.signupPhonenumber,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          SizedBox(height: PSizes.spaceBtwInputField),

          //password
          TextFormField(
            expands: false,
            decoration: InputDecoration(
              labelText: PTexts.password,
              prefixIcon: Icon(Iconsax.password_check),
              suffixIcon: Icon(Iconsax.eye_slash),
            ),
          ),
          SizedBox(height: PSizes.spaceBtwSections),

          //terms and condition check box
          TermsandConditionCheckbox(),
          SizedBox(height: PSizes.spaceBtwSections),
          // Signup button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Get.to(VerifyEmailScreen()),
              child: Text("Create Account"),
            ),
          ),
        ],
      ),
    );
  }
}
