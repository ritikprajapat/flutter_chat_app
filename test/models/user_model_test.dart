import 'package:flutter_test/flutter_test.dart';
import 'package:chat_application/src/data/models/user_model.dart';

void main() {
  test('User.initial returns uppercase first character', () {
    final u = User(id: '1', name: 'alice');
    expect(u.initial, 'A');
  });

  test('ChatHistory.timeAgo shows minutes/hours/days correctly', () {
    final now = DateTime.now();
    final fiveMin = ChatHistory(
      id: '1',
      user: User(id: '2', name: 'Bob'),
      lastMessage: 'hi',
      lastChatTime: now.subtract(Duration(minutes: 5)),
    );
    expect(fiveMin.timeAgo, '5m');

    final twoHours = ChatHistory(
      id: '2',
      user: User(id: '3', name: 'Eve'),
      lastMessage: 'hey',
      lastChatTime: now.subtract(Duration(hours: 2)),
    );
    expect(twoHours.timeAgo, '2h');

    final oneDay = ChatHistory(
      id: '3',
      user: User(id: '4', name: 'Tom'),
      lastMessage: 'yo',
      lastChatTime: now.subtract(Duration(days: 1)),
    );
    expect(oneDay.timeAgo, '1d');
  });
}
