import 'package:chat_application/src/app/app.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('app smoke test - open app and switch tab', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Users'), findsOneWidget);

    await tester.tap(find.text('Chat History'));
    await tester.pumpAndSettle();
    

    expect(find.text('Chat History'), findsOneWidget);
  });
}
