import 'package:flutter/material.dart';

class GradientAvatar extends StatelessWidget {
  final String initial;
  final bool isOnline;
  final double size;

  const GradientAvatar({super.key, required this.initial, this.isOnline = false, this.size = 48});

  static const _startColors = [
    Color(0xFF6366F1),
    Color(0xFFEC4899),
    Color(0xFF10B981),
    Color(0xFFF59E0B),
    Color(0xFF8B5CF6),
    Color(0xFF06B6D4),
  ];

  static const _endColors = [
    Color(0xFF8B5CF6),
    Color(0xFFF472B6),
    Color(0xFF059669),
    Color(0xFFDC2626),
    Color(0xFFA78BFA),
    Color(0xFF22D3EE),
  ];

  int _colorIndex(String text) {
    if (text.isEmpty) return 0;
    return text.codeUnitAt(0) % _startColors.length;
  }

  @override
  Widget build(BuildContext context) {
    final index = _colorIndex(initial);
    final startColor = _startColors[index];
    final endColor = _endColors[index];

    return Stack(
      clipBehavior: Clip.none,
      children: [_avatarBody(startColor, endColor), if (isOnline) _onlineIndicator()],
    );
  }

  Widget _avatarBody(Color start, Color end) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(colors: [start, end], begin: Alignment.topLeft, end: Alignment.bottomRight),
        boxShadow: [BoxShadow(color: start.withValues(alpha: 0.5), blurRadius: size * 0.3, offset: const Offset(0, 5))],
      ),
      alignment: Alignment.center,
      child: Text(
        initial.isNotEmpty ? initial[0].toUpperCase() : '?',
        style: TextStyle(color: Colors.white, fontSize: size * 0.4, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _onlineIndicator() {
    final indicatorSize = size * 0.25;

    return Positioned(
      right: 2,
      bottom: 2,
      child: Container(
        width: indicatorSize,
        height: indicatorSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(colors: [Color(0xFF10B981), Color(0xFF059669)]),
          border: Border.all(color: const Color(0xFF0A0E27), width: indicatorSize * 0.2),
          boxShadow: [
            BoxShadow(color: const Color(0xFF10B981).withValues(alpha: 0.8), blurRadius: indicatorSize * 0.8),
          ],
        ),
      ),
    );
  }
}
