import 'package:chat/controllers/auth.dart';
import 'package:chat/ui/components/the_text_field.dart';
import 'package:chat/ui/screens/reset.dart';
import 'package:chat/ui/screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  AuthController auth = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/icon.png", width: 80, height: 80),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Welcome, Sign in",
                style: TextStyle(
                    fontSize: 24, color: Get.theme.colorScheme.primary),
              ),
              const SizedBox(
                height: 8,
              ),
              TheTextField(
                  controller: auth.email,
                  obscureText: false,
                  labelText: "Email"),
              const SizedBox(
                height: 8,
              ),
              TheTextField(
                  controller: auth.password,
                  obscureText: true,
                  labelText: "Password"),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (await auth.signIn()) {}
                  },
                  child: const Text("Sign in"),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Forgot Password?"),
                  const SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const ResetScreen());
                    },
                    child: Text(
                      "Reset",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Get.theme.colorScheme.primary),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have account?"),
                  const SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const SignUpScreen());
                    },
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Get.theme.colorScheme.primary),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
