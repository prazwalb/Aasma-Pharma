import 'package:android_std/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:android_std/features/authentication/screens/signup/signup.dart';
import 'package:android_std/navigation_menu.dart';
import 'package:android_std/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:iconsax/iconsax.dart';

class Login_Form extends StatelessWidget {
  const Login_Form({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: PSizes.spaceBtwSections),
        child: Column(
          children: [
            //email
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.direct),
                labelText: "Enter Your Email",
              ),
            ),
            SizedBox(height: PSizes.spaceBtwInputField),

            //password
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.password_check),
                labelText: "Enter Your Password",
                suffixIcon: Icon(Iconsax.eye_slash),
              ),
            ),
            SizedBox(height: PSizes.spaceBtwInputField),

            //remember me and forget password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 24,
                      width: 24,
                      child: Checkbox(value: true, onChanged: (value) {}),
                    ),
                    const Text('Remember me'),
                  ],
                ),

                // forget password
                TextButton(
                  onPressed: () => Get.to(ForgetPassword()),
                  child: Text("Forget Password"),
                ),
              ],
            ),
            const SizedBox(height: PSizes.spaceBtwInputField),

            //sign in button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.to(NavigationMenu()),
                child: Text("Sign In"),
              ),
            ),
            const SizedBox(height: PSizes.spaceBtwItems),
            //create account button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.to(SignupScreen()),
                child: Text("Create Account"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
