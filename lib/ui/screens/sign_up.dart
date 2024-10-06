import 'package:chat/controllers/auth.dart';
import 'package:chat/ui/components/the_text_field.dart';
import 'package:chat/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                "Welcome, Sign up",
                style: TextStyle(
                    fontSize: 24, color: Get.theme.colorScheme.primary),
              ),
              const SizedBox(
                height: 8,
              ),
              TheTextField(
                  controller: auth.firstName,
                  obscureText: false,
                  labelText: "First name"),
              const SizedBox(
                height: 8,
              ),
              TheTextField(
                  controller: auth.lastName,
                  obscureText: false,
                  labelText: "Last name"),
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
                    if (await auth.signUp()) {
                      Get.back();
                      success("User account created.");
                    }
                  },
                  child: const Text("Sign up"),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have account?"),
                  const SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Text(
                      "Sign in",
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
