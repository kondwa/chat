import 'package:chat/controllers/auth.dart';
import 'package:chat/ui/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TheDrawer extends StatefulWidget {
  const TheDrawer({super.key});

  @override
  State<TheDrawer> createState() => _TheDrawerState();
}

class _TheDrawerState extends State<TheDrawer> {
  AuthController auth = Get.find();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Get.theme.colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                  child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.message,
                      size: 60,
                      color: Get.theme.colorScheme.primary,
                    ),
                    Text(
                      auth.user.displayName.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(auth.user.email.toString())
                  ],
                ),
              )),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: ListTile(
                  title: const Text("H O M E"),
                  leading: const Icon(Icons.home),
                  onTap: () {
                    Get.back();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: ListTile(
                  title: const Text("S E T T I N G S"),
                  leading: const Icon(Icons.settings),
                  onTap: () {
                    Get.back();
                    Get.to(() => const SettingsScreen());
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 24),
            child: ListTile(
              title: const Text("S I G N   O U T"),
              leading: const Icon(Icons.logout),
              onTap: () async {
                Get.back();
                if (await auth.signOut()) {}
              },
            ),
          )
        ],
      ),
    );
  }
}
