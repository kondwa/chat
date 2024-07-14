import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  final _darkMode = false.obs;

  bool get isDarkMode => _darkMode.value;

  ThemeMode get mode => isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void toggle() {
    _darkMode.value = !_darkMode.value;
    Get.changeThemeMode(mode);
  }
}
