import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TheTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String labelText;
  final FocusNode? focusNode;

  const TheTextField(
      {super.key,
      required this.controller,
      required this.obscureText,
      required this.labelText,
      this.focusNode});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Get.theme.colorScheme.secondary)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Get.theme.colorScheme.primary)),
          labelText: labelText),
    );
  }
}
