import 'package:chat/models/message.dart';
import 'package:chat/models/person.dart';
import 'package:chat/models/report.dart';
import 'package:chat/utils/functions.dart';
import 'package:chat/utils/sd.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nanoid/nanoid.dart';

class ChatController extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController message = TextEditingController();

  User get user => auth.currentUser as User;

  Person get me => Person(
      uid: user.uid,
      email: user.email.toString(),
      displayName: user.displayName.toString());

  //get user stream
  Stream<List<Person>> peopleStream() {
    try {
      return db.collection(SD.people).snapshots().map((snapshot) {
        return snapshot.docs.where((doc) => doc.id != me.uid).map((doc) {
          final person = Person.fromJson(doc.data());
          return person;
        }).toList();
      });
    } on FirebaseException catch (e) {
      exception(e.message);
    } on Exception catch (e) {
      exception(e.toString());
    }
    return const Stream.empty();
  }

  //get unblocked users streams
  Stream<List<Person>> unblockedStream() {
    try {
      return db
          .collection(SD.people)
          .doc(me.uid)
          .collection(SD.blocked)
          .snapshots()
          .asyncMap((snapshot) async {
        var blockedIds = snapshot.docs.map((doc) => doc.id).toList();
        var userSnapshots = await db.collection(SD.people).get();
        return userSnapshots.docs
            .where((doc) => doc.id != me.uid && !blockedIds.contains(doc.id))
            .map((doc) => Person.fromJson(doc.data()))
            .toList();
      });
    } on FirebaseException catch (e) {
      exception(e.message);
    } on Exception catch (e) {
      exception(e.toString());
    }
    return const Stream.empty();
  }

//send message
  Future<bool> sendTo(String receiverUID) async {
    String senderUID = user.uid;
    if (validated()) {
      String id = nanoid();
      final chatMessage = Message(
          id: id,
          senderUID: senderUID,
          receiverUID: receiverUID,
          message: message.text,
          timestamp: DateTime.now());
      String chatroom = chatroomID(senderUID, receiverUID);
      try {
        await db
            .collection(SD.rooms)
            .doc(chatroom)
            .collection(SD.messages)
            .doc(id)
            .set(chatMessage.toJson());
        message.clear();
        return true;
      } on FirebaseException catch (e) {
        exception(e.message);
      } on Exception catch (e) {
        exception(e.toString());
      }
    }
    return false;
  }

  String chatroomID(String senderUID, String receiverUID) {
    List<String> uids = [senderUID, receiverUID];
    uids.sort();
    return uids.join("_");
  }

  bool validated() {
    if (message.text.isEmpty) {
      return false;
    }
    return true;
  }

//get messages
  Stream<List<Message>> messageStream(String meUID, String friendUID) {
    String chatroom = chatroomID(meUID, friendUID);
    try {
      return db
          .collection(SD.rooms)
          .doc(chatroom)
          .collection(SD.messages)
          .orderBy("timestamp", descending: false)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return Message.fromJson(doc.data());
        }).toList();
      });
    } on FirebaseException catch (e) {
      exception(e.message);
    } on Exception catch (e) {
      exception(e.toString());
    }
    return const Stream.empty();
  }

// report user
  Future<bool> report(String messageId, String senderUID) async {
    final report = Report(
        reportedByUID: me.uid,
        messageId: messageId,
        senderUID: senderUID,
        timestamp: DateTime.now());
    try {
      await db.collection(SD.reports).add(report.toJson());
      return true;
    } on FirebaseException catch (e) {
      exception(e.message);
    } on Exception catch (e) {
      exception(e.toString());
    }
    return false;
  }

// block user
  Future<bool> block(String personID) async {
    try {
      await db
          .collection(SD.people)
          .doc(me.uid)
          .collection(SD.blocked)
          .doc(personID)
          .set({});
      return true;
    } on FirebaseException catch (e) {
      exception(e.message);
    } on Exception catch (e) {
      exception(e.toString());
    }
    return false;
  }

// unblock user
  Future<bool> unblock(String personID) async {
    try {
      await db
          .collection(SD.people)
          .doc(me.uid)
          .collection(SD.blocked)
          .doc(personID)
          .delete();
      return true;
    } on FirebaseException catch (e) {
      exception(e.message);
    } on Exception catch (e) {
      exception(e.toString());
    }
    return false;
  }

// get blocked users
  Stream<List<Person>> blockedStream() {
    try {
      return db
          .collection(SD.people)
          .doc(me.uid)
          .collection(SD.blocked)
          .snapshots()
          .asyncMap((snapshot) async {
        var blockedIds = snapshot.docs.map((doc) => doc.id).toList();
        var blockedDocs = await Future.wait(blockedIds
            .map((uid) async => await db.collection(SD.people).doc(uid).get()));
        return blockedDocs.map((doc) => Person.fromJson(doc.data())).toList();
      });
    } on FirebaseException catch (e) {
      exception(e.message);
    } on Exception catch (e) {
      exception(e.toString());
    }
    return const Stream.empty();
  }
}
