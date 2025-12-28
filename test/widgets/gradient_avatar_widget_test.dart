import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chat_application/src/core/widgets/gradient_avatar_widget.dart';

void main() {
  testWidgets('GradientAvatarWidget shows initial and online indicator', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: GradientAvatarWidget(initial: 'R', isOnline: true, size: 48)),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('R'), findsOneWidget);
    // online indicator is a Positioned widget in the stack
    expect(find.byType(Positioned), findsWidgets);
  });
}
