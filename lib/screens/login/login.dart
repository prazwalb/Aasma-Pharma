import 'package:android_std/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool ispassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            context.goNamed('onboard');
          },
        ),
      ),
      body: Column(
        children: [
          const Center(
            child: Text(
              'Sign in now',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Please sign in to continue to our app',
            style: TextStyle(color: Colors.grey[800]),
          ),
          const SizedBox(height: 20),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(PSizes.defaultSpace),
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Enter your email address',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _emailController.clear();
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !ispassword,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: '.........',
                      suffixIcon: IconButton(
                        icon: ispassword
                            ? const Icon(Icons.abc)
                            : const Icon(Icons.remove_red_eye),
                        onPressed: () {
                          setState(() {
                            ispassword = !ispassword;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextButton(
                  onPressed: () {
                    context.goNamed('forgotpass');
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 5, 94, 248),
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {}
              },
              child: TextButton(
                onPressed: () {
                  context.goNamed('homepage');
                },
                child: const Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(height: 22),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Dont have an account?'),
              TextButton(
                onPressed: () {
                  return context.goNamed('signup');
                },
                child: const Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text('Or Connect'),
          const SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                child: Image.network(
                  'https://img.icons8.com/?size=96&id=uLWV5A9vXIPu&format=png',
                  height: 50,
                  width: 50,
                  fit: BoxFit.contain,
                ),
                onTap: () {
                  context.goNamed('photos');
                },
              ),
              GestureDetector(
                child: Image.network(
                  'https://img.icons8.com/?size=96&id=Xy10Jcu1L2Su&format=png',
                  height: 50,
                  width: 50,
                  fit: BoxFit.contain,
                ),
                onTap: () {
                  context.goNamed('popularplace');
                },
              ),
              GestureDetector(
                child: Image.network(
                  'https://img.icons8.com/?size=128&id=119014&format=png',
                  height: 50,
                  width: 50,
                  fit: BoxFit.contain,
                ),
                onTap: () {
                  context.goNamed('profilepage');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
