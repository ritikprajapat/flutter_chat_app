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

class ChatHistory {
  final String id;
  final User user;
  final String lastMessage;
  final DateTime lastChatTime;
  final int unreadCount;

  ChatHistory({
    required this.id,
    required this.user,
    required this.lastMessage,
    required this.lastChatTime,
    this.unreadCount = 0,
  });

  String get timeAgo {
    final diff = DateTime.now().difference(lastChatTime);
    if (diff.inMinutes < 1) return 'now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    if (diff.inDays == 1) return '1d';
    if (diff.inDays < 7) return '${diff.inDays}d';
    return '${lastChatTime.day}/${lastChatTime.month}';
  }
}
