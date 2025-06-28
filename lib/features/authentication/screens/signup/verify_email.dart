import 'package:android_std/common/widgets/success_screen/success_screen.dart';
import 'package:android_std/features/authentication/screens/login/login.dart';
import 'package:android_std/utils/constants/image_strings.dart';
import 'package:android_std/utils/constants/sizes.dart';
import 'package:android_std/utils/constants/text_strings.dart';
import 'package:android_std/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.offAll(() => const LoginScreen()),
            icon: Icon(Icons.clear_sharp),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(PSizes.defaultSpace),
          child: Column(
            children: [
              Image(
                image: AssetImage(PImage.ani),
                height: 200,
                width: PHelperFunction.screenWidth(),
              ),
              SizedBox(height: PSizes.spaceBtwSections),
              Text(
                PTexts.configureEmailTitle,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: PSizes.spaceBtwItems),
              Text(
                'supporrt@gmail.com',
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: PSizes.spaceBtwItems),

              Text(
                PTexts.configureEmailsubTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: PSizes.spaceBtwSections),

              //buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.to(
                    SuccessScreen(
                      image: PImage.ani,
                      title: PTexts.configureEmailTitle,
                      subtitle: PTexts.configureEmailsubTitle,
                      onPressed: () => Get.to(LoginScreen()),
                    ),
                  ),
                  child: Text(PTexts.eContinue),
                ),
              ),
              SizedBox(height: PSizes.spaceBtwItems),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {},
                  child: Text(PTexts.eResend),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
