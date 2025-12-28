import '../../../app/app.dart';

class ChatView extends StatelessWidget {
  final User user;
  const ChatView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatViewModel>(
      builder: (context, vm, _) {
        final messages = vm.messagesFor(user.id);

        return Scaffold(
          backgroundColor: const Color(0xFF0A0E27),
          appBar: AppBar(backgroundColor: const Color(0xFF0A0E27), title: Text(user.name)),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: vm.scrollController,
                  padding: const EdgeInsets.all(20),
                  itemCount: messages.length,
                  itemBuilder: (_, i) => MessageBubbleWidget(message: messages[i]),
                ),
              ),

              if (vm.isLoading) _typingIndicator(user),

              _inputBar(vm, user),
            ],
          ),
        );
      },
    );
  }

  Widget _typingIndicator(User user) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          GradientAvatarWidget(initial: user.initial, size: 32),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: const SizedBox(
              width: 50,
              height: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [TypingDot(delay: 0), TypingDot(delay: 200), TypingDot(delay: 400)],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputBar(ChatViewModel vm, User user) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(30)),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: vm.textController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(hintText: 'Type a message...', border: InputBorder.none),
              onSubmitted: (_) => vm.sendMessage(user),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.white),
            onPressed: () => vm.sendMessage(user),
          ),
        ],
      ),
    );
  }
}
