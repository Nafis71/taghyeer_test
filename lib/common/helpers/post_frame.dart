import 'package:flutter/cupertino.dart';

class PostFrame {
  static void executeTask({required Function task}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      task();
    });
  }
}
