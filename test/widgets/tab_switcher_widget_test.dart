import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chat_application/src/core/widgets/tab_switcher_widget.dart';

void main() {
  testWidgets('TabSwitcherWidget shows selected style and responds to taps', (tester) async {
    int? tapped;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: TabSwitcherWidget(selectedTab: 0, onTabChanged: (i) => tapped = i)),
      ),
    );

    await tester.pumpAndSettle();

    final usersText = find.text('Users');
    expect(usersText, findsOneWidget);
    final usersWidget = tester.widget<Text>(usersText);
    expect(usersWidget.style?.color, Colors.white);

    await tester.tap(find.text('Chat History'));
    await tester.pump();
    expect(tapped, 1);
  });
}
