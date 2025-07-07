import 'package:android_std/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:android_std/utils/constants/sizes.dart';
import 'package:android_std/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(PSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //heading
            Text(
              PTexts.forgetPasswordTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: PSizes.spaceBtwItems),
            Text(
              PTexts.forgetPasswordsubTitle,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            SizedBox(height: PSizes.spaceBtwSections),

            TextField(
              decoration: InputDecoration(
                labelText: PTexts.email,
                prefixIcon: Icon(Iconsax.direct),
              ),
            ),
            SizedBox(height: PSizes.spaceBtwSections),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.off(ResetPassword());
                },
                child: Text(PTexts.submit),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
