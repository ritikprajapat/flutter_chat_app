import 'package:flutter/material.dart';

class SnackBarHelper {
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  static void show({
    required String message,
    Color? backgroundColor,
    IconData? icon,
    Duration duration = const Duration(seconds: 5),
  }) {
    if (message.trim().isEmpty) return;
    final messenger = scaffoldMessengerKey.currentState;
    messenger?.clearSnackBars();
    messenger?.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        closeIconColor: Colors.white,
        backgroundColor: backgroundColor ?? Colors.black,
        elevation: 4,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: duration,
        content: Row(
          children: [
            if (icon != null) ...[Icon(icon, color: Colors.white, size: 20), const SizedBox(width: 8)],
            Expanded(
              child: Text(message, style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  static void success(String? message) =>
      show(message: message ?? "", backgroundColor: Colors.green, icon: Icons.check_circle_rounded);

  static void error(String? message) =>
      show(message: message ?? "", backgroundColor: Colors.red, icon: Icons.error_outline_rounded);

  static void info(String? message) =>
      show(message: message ?? "", backgroundColor: Colors.blue, icon: Icons.info_outline_rounded);
}
