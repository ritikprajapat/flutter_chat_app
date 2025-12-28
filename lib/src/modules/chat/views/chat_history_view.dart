import '../../../app/app.dart';

class ChatHistoryList extends StatelessWidget {
  final ScrollController scrollController;
  const ChatHistoryList({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatViewModel>(
      builder: (context, vm, child) {
        if (vm.chatHistories.isEmpty) {
          return _emptyState();
        }

        return ListView.builder(
          controller: scrollController,
          padding: const EdgeInsets.all(20),
          itemCount: vm.chatHistories.length,
          itemBuilder: (context, index) {
            final h = vm.chatHistories[index];

            return Padding(padding: const EdgeInsets.only(bottom: 12), child: _chatTile(context, vm, h));
          },
        );
      },
    );
  }

  Widget _chatTile(BuildContext context, ChatViewModel vm, ChatHistory h) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChatView(user: h.user))),
        onLongPress: () => vm.onChatHistoryLongPress(context: context, message: h.lastMessage),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              GradientAvatarWidget(initial: h.user.initial, isOnline: h.user.isOnline, size: 56),
              const SizedBox(width: 16),
              Expanded(child: _chatInfo(h)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chatInfo(ChatHistory h) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                h.user.name,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17, color: Colors.white),
              ),
            ),
            Text(h.timeAgo, style: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.5))),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: Text(
                h.lastMessage,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 15, color: Colors.white.withValues(alpha: 0.6)),
              ),
            ),
            if (h.unreadCount > 0) _unreadBadge(h.unreadCount),
          ],
        ),
      ],
    );
  }

  Widget _unreadBadge(int count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)]),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '$count',
        style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.chat_bubble_outline, size: 60, color: Colors.white54),
          const SizedBox(height: 16),
          const Text('No chat history', style: TextStyle(fontSize: 18, color: Colors.white70)),
        ],
      ),
    );
  }
}
