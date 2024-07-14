import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

void success(message) {
  Get.snackbar("Success", message);
}

void exception(message) {
  Get.snackbar("Exception", message);
}

Future<bool> confirm(message) async {
  return await Get.defaultDialog(
      title: "Confirmation",
      cancel: ElevatedButton(
          onPressed: () {
            Get.back(result: false);
          },
          child: const Text("No")),
      confirm: ElevatedButton(
          onPressed: () {
            Get.back(result: true);
          },
          child: const Text("Yes")),
      content: Text(message));
}
