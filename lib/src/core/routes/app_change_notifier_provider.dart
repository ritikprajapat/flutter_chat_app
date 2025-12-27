import 'package:chat_application/src/modules/chat/view_models/chat_view_model.dart';
import 'package:chat_application/src/modules/home/view_models/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppChangeNotifierProvider {
  static final providers = [
    createProvider<HomeViewModel>(create: () => HomeViewModel()),
    createProvider<ChatViewModel>(create: () => ChatViewModel()),
  ];
  static ChangeNotifierProvider<T> createProvider<T extends ChangeNotifier>({
    required T Function() create,
    Widget? child,
  }) {
    return ChangeNotifierProvider<T>(create: (context) => create(), child: child);
  }
}
