import 'package:chat/controllers/auth.dart';
import 'package:chat/controllers/chat.dart';
import 'package:chat/controllers/theme.dart';
import 'package:chat/models/person.dart';
import 'package:chat/ui/components/the_text_field.dart';
import 'package:chat/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen(this.friend, {super.key});

  final Person friend;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  AuthController auth = Get.find();
  ChatController chat = Get.find();
  ThemeController theme = Get.find();
  ScrollController scrollController = ScrollController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        Future.delayed(const Duration(seconds: 1), () {
          scrollDown();
        });
      }
    });
    Future.delayed(const Duration(seconds: 1), () {
      scrollDown();
    });
    super.initState();
  }

  void scrollDown() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn);
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  void showOptions(String senderUID, String messageID) {
    Get.bottomSheet(Card(
      child: Wrap(
        children: [
          ListTile(
            title: const Text("Report message"),
            leading: const Icon(Icons.flag),
            onTap: () async {
              if (await confirm("Report this message?")) {
                if (await chat.report(messageID, senderUID)) {
                  Get.back();
                  success("Message reported");
                }
              } else {
                Get.back();
              }
            },
          ),
          ListTile(
            title: const Text("Block message sender"),
            leading: const Icon(Icons.block),
            onTap: () async {
              if (await confirm("Block the message sender?")) {
                if (await chat.block(senderUID)) {
                  Get.back();
                  Get.back();
                  success("The message sender blocked");
                }
              } else {
                Get.back();
              }
            },
          ),
          ListTile(
            title: const Text("Close menu"),
            leading: const Icon(Icons.close),
            onTap: () {
              Get.back();
            },
          )
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: Text(
            widget.friend.displayName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(widget.friend.email),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: chat.messageStream(chat.me.uid, widget.friend.uid),
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
                  var messages = snapshot.data ?? [];
                  return ListView.builder(
                      controller: scrollController,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        var message = messages[index];
                        Person sender = message.senderUID == chat.me.uid
                            ? chat.me
                            : widget.friend;
                        final green = theme.isDarkMode
                            ? Colors.green.shade900
                            : Colors.green.shade50;
                        final grey = theme.isDarkMode
                            ? Colors.grey.shade800
                            : Colors.grey.shade200;
                        return GestureDetector(
                          onLongPress: () {
                            if (sender.uid == widget.friend.uid) {
                              showOptions(sender.uid, message.id);
                            }
                          },
                          child: Card(
                            color: sender.uid == chat.me.uid ? green : grey,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: sender.uid == chat.me.uid
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    sender.displayName,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(message.message)
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: TheTextField(
                  focusNode: focusNode,
                  controller: chat.message,
                  obscureText: false,
                  labelText: "Message",
                )),
                IconButton(
                    onPressed: () async {
                      if (await chat.sendTo(widget.friend.uid)) {
                        scrollDown();
                      }
                    },
                    icon: const Icon(
                      Icons.send,
                      color: Colors.green,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
