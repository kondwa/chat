import 'package:chat/controllers/auth.dart';
import 'package:chat/controllers/chat.dart';
import 'package:chat/controllers/theme.dart';
import 'package:get/get.dart';

class Binding {
  static init() {
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => ChatController(), fenix: true);
    Get.lazyPut(() => ThemeController(), fenix: true);
  }
}
