import 'package:android_std/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

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
                prefixIcon: Icon(Icons.arrow_right),
                labelText: "Enter Your Email",
              ),
            ),
            SizedBox(height: PSizes.spaceBtwInputField),

            //password
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.password),
                labelText: "Enter Your Password",
                suffixIcon: Icon(Icons.remove_red_eye),
              ),
            ),
            // SizedBox(height: PSizes.spaceBtwInputField),

            //remember me and forget password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (value) {}),
                    const Text('Remember me'),
                  ],
                ),

                // forget password
                TextButton(onPressed: () {}, child: Text("Forget Passwprd")),
              ],
            ),
            const SizedBox(height: PSizes.spaceBtwInputField),

            //sign in button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () {}, child: Text("Sign_In")),
            ),
            const SizedBox(height: PSizes.spaceBtwItems),
            //create account button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                child: Text("Create Account"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
