import 'package:chat/models/person.dart';
import 'package:chat/utils/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  User get user => auth.currentUser as User;

  Future<bool> signIn() async {
    try {
      if (validSignIn()) {
        await auth.signInWithEmailAndPassword(
            email: email.text, password: password.text);
        await subscribe();
        clear();
      }
    } on FirebaseException catch (e) {
      exception(e.message);
    } on Exception catch (e) {
      exception(e.toString());
    }
    return false;
  }

  Future<bool> signUp() async {
    try {
      if (validSignUp()) {
        await auth.createUserWithEmailAndPassword(
            email: email.text, password: password.text);
        await auth.currentUser
            ?.updateDisplayName("${firstName.text} ${lastName.text}");
        await subscribe();
        clear();
        return true;
      }
    } on FirebaseException catch (e) {
      exception(e.message);
    } on Exception catch (e) {
      exception(e.toString());
    }
    return false;
  }

  Future<bool> signOut() async {
    try {
      await auth.signOut();
      return true;
    } on FirebaseException catch (e) {
      exception(e.message);
    } on Exception catch (e) {
      exception(e.toString());
    }
    return false;
  }

  Future<void> subscribe() async {
    var person = Person(
        uid: user.uid,
        email: user.email as String,
        displayName: user.displayName as String);
    try {
      await db.collection("people").doc(user.uid).set(person.toJson());
    } on FirebaseException catch (e) {
      exception(e.message);
    } on Exception catch (e) {
      exception(e.toString());
    }
  }

  Stream<User?> stream() {
    try {
      return auth.authStateChanges();
    } on FirebaseException catch (e) {
      exception(e.message);
    } on Exception catch (e) {
      exception(e.toString());
    }
    return const Stream.empty();
  }

  Future<bool> reset() async {
    try {
      if (validReset()) {
        await auth.sendPasswordResetEmail(email: email.text);
        clear();
        return true;
      }
    } on FirebaseException catch (e) {
      exception(e.message);
    } on Exception catch (e) {
      exception(e.toString());
    }
    return false;
  }

  bool validSignIn() {
    if (email.text.isEmpty) {
      exception("Email is required.");
      return false;
    }
    if (password.text.isEmpty) {
      exception("Password is required.");
      return false;
    }
    return true;
  }

  bool validSignUp() {
    if (firstName.text.isEmpty) {
      exception("First name is required.");
      return false;
    }
    if (lastName.text.isEmpty) {
      exception("Last name is required.");
      return false;
    }
    if (email.text.isEmpty) {
      exception("Email is required.");
      return false;
    }
    if (password.text.isEmpty) {
      exception("Password is required.");
      return false;
    }
    return true;
  }

  bool validReset() {
    if (email.text.isEmpty) {
      exception("Email is required.");
      return false;
    }
    return true;
  }

  void clear() {
    firstName.clear();
    lastName.clear();
    email.clear();
    password.clear();
  }
}
