import 'package:android_std/common/styles/spacing_styles.dart';
import 'package:android_std/common/widgets/login_signup/form_divider.dart';
import 'package:android_std/common/widgets/login_signup/social_button.dart';
import 'package:android_std/features/authentication/screens/login/widgets/login_form.dart';
import 'package:android_std/features/authentication/screens/login/widgets/login_header.dart';
import 'package:android_std/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: PSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //logo,title and subtitle
              Login_Header(),
              //form
              Login_Form(),

              //divider
              FormDivider(dividerText: 'Or Login With'),
              //footter
              SizedBox(height: PSizes.spaceBtwSections),
              SocialButton(),
            ],
          ),
        ),
      ),
    );
  }
}
