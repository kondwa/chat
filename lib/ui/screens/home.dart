import 'package:chat/controllers/auth.dart';
import 'package:chat/controllers/chat.dart';
import 'package:chat/ui/components/the_drawer.dart';
import 'package:chat/ui/screens/chat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthController auth = Get.find();
  ChatController chat = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
      ),
      drawer: const TheDrawer(),
      body: StreamBuilder(
        stream: chat.unblockedStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          final people = snapshot.data ?? [];
          return ListView.builder(
              itemCount: people.length,
              itemBuilder: (context, index) {
                final person = people[index];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(
                      person.displayName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(person.email),
                    onTap: () {
                      Get.to(() => ChatScreen(person));
                    },
                  ),
                );
              });
        },
      ),
    );
  }
}
