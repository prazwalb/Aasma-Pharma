import 'package:android_std/common/styles/spacing_styles.dart';
import 'package:android_std/features/authentication/screens/login/widgets/login_footer.dart';
import 'package:android_std/features/authentication/screens/login/widgets/login_form.dart';
import 'package:android_std/features/authentication/screens/login/widgets/login_header.dart';
import 'package:android_std/utils/constants/colors.dart';
import 'package:android_std/utils/helpers/helper_function.dart';
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
              FormDivider(),
              //footter
              SocialButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class FormDivider extends StatelessWidget {
  const FormDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = PHelperFunction.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Divider(
            color: dark ? PColors.darkGrey : PColors.grey,
            thickness: 0.5,
            indent: 60,
            endIndent: 5,
          ),
        ),
        Text('Or Sign In With', style: Theme.of(context).textTheme.labelMedium),
        Flexible(
          child: Divider(
            color: dark ? PColors.darkGrey : PColors.grey,
            thickness: 0.5,
            indent: 5,
            endIndent: 60,
          ),
        ),
      ],
    );
  }
}
