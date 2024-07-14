import 'package:chat/controllers/auth.dart';
import 'package:chat/ui/screens/home.dart';
import 'package:chat/ui/screens/sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  AuthController auth = Get.find();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: auth.stream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return const SignInScreen();
          }
        });
  }
}
