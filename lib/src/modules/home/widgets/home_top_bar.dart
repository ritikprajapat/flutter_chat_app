import 'dart:ui';
import 'package:flutter/material.dart';

class HomeTopBar extends StatelessWidget {
  final bool visible;
  final Widget child;

  const HomeTopBar({super.key, required this.visible, required this.child});

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;

    return ClipRect(
      child: AnimatedAlign(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeInOutCubic,
        alignment: Alignment.topCenter,
        heightFactor: visible ? 1 : 0,
        child: Padding(
          padding: EdgeInsets.only(top: topInset > 30 ? 8 : 16, left: 16, right: 16, bottom: 12),
          child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18), child: child),
        ),
      ),
    );
  }
}
