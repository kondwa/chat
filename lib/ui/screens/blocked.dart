import 'package:chat/controllers/chat.dart';
import 'package:chat/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlockedScreen extends StatefulWidget {
  const BlockedScreen({super.key});

  @override
  State<BlockedScreen> createState() => _BlockedScreenState();
}

class _BlockedScreenState extends State<BlockedScreen> {
  ChatController chat = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blocked People"),
      ),
      body: StreamBuilder(
        stream: chat.blockedStream(),
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
          var people = snapshot.data ?? [];
          if (people.isEmpty) {
            return const Center(
              child: Text("No blocked people."),
            );
          }
          return ListView.builder(
              itemCount: people.length,
              itemBuilder: (context, index) {
                var person = people[index];
                return ListTile(
                  title: Text(
                    person.displayName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(person.email),
                  onTap: () async {
                    if (await confirm("Unblock this person?")) {
                      if (await chat.unblock(person.uid)) {
                        success("Person unblocked.");
                      }
                    }
                  },
                );
              });
        },
      ),
    );
  }
}
