import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.red.shade500));
ThemeData darkMode =
    ThemeData(useMaterial3: true, colorScheme: const ColorScheme.dark());
