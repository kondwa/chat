import 'package:chat/controllers/auth.dart';
import 'package:chat/ui/screens/sign_in.dart';
import 'package:chat/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({super.key});

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
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
                  "Reset Password",
                  style: TextStyle(
                      fontSize: 24, color: Get.theme.colorScheme.primary),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: auth.email,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Email"),
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (await auth.reset()) {
                        Get.back();
                        success("Password reset link sent.");
                      }
                    },
                    child: const Text("Get reset link"),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Changed your mind?"),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const SignInScreen());
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
        ));
  }
}
