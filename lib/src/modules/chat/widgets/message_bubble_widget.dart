import '../../../app/app.dart';

class MessageBubbleWidget extends StatelessWidget {
  final Message message;
  const MessageBubbleWidget({super.key, required this.message});

  void _showMeaning(BuildContext context, String word) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => WordMeaningWidget(word: word),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        final words = message.text.split(' ');
        if (words.isNotEmpty) {
          final word = words[0].replaceAll(RegExp(r'[^\w\s]'), '');
          if (word.isNotEmpty) _showMeaning(context, word);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          mainAxisAlignment: message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (!message.isSender) ...[
              GradientAvatarWidget(initial: message.userInitial, size: 32),
              const SizedBox(width: 12),
            ],
            Flexible(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                decoration: BoxDecoration(
                  gradient: message.isSender
                      ? const LinearGradient(colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)])
                      : null,
                  color: message.isSender ? null : Colors.white.withValues(alpha: 0.05),
                  border: message.isSender ? null : Border.all(color: Colors.white.withValues(alpha: 0.1), width: 1),
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(24),
                    topRight: const Radius.circular(24),
                    bottomLeft: Radius.circular(message.isSender ? 24 : 6),
                    bottomRight: Radius.circular(message.isSender ? 6 : 24),
                  ),
                  boxShadow: message.isSender
                      ? [
                          BoxShadow(
                            color: const Color(0xFF6366F1).withValues(alpha: 0.4),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectableText(
                      message.text,
                      style: TextStyle(
                        color: message.isSender ? Colors.white : Colors.white.withValues(alpha: 0.9),
                        fontSize: 15,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _formatTime(message.timestamp),
                      style: TextStyle(
                        color: message.isSender ? Colors.white70 : Colors.white.withValues(alpha: 0.5),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (message.isSender) ...[
              const SizedBox(width: 12),
              GradientAvatarWidget(initial: message.userInitial, size: 32),
            ],
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final hour = time.hour > 12 ? time.hour - 12 : (time.hour == 0 ? 12 : time.hour);
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }
}
