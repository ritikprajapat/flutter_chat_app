class User {
  final String id;
  final String name;
  final bool isOnline;

  User({required this.id, required this.name, this.isOnline = false});

  String get initial => name.isNotEmpty ? name[0].toUpperCase() : '?';
}

class Message {
  final String id;
  final String text;
  final bool isSender;
  final DateTime timestamp;
  final String userInitial;

  Message({
    required this.id,
    required this.text,
    required this.isSender,
    required this.timestamp,
    required this.userInitial,
  });
}
