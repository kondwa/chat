import 'package:chat/controllers/auth.dart';
import 'package:chat/controllers/theme.dart';
import 'package:chat/ui/screens/blocked.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  AuthController auth = Get.find();
  ThemeController theme = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
                title: const Text("Dark Mode"),
                trailing: Switch(
                    value: theme.isDarkMode,
                    onChanged: (value) {
                      theme.toggle();
                    })),
            ListTile(
              title: const Text("Blocked People"),
              trailing: IconButton(
                  onPressed: () {
                    Get.to(() => const BlockedScreen());
                  },
                  icon: const Icon(Icons.arrow_forward)),
            )
          ],
        ),
      ),
    );
  }
}
