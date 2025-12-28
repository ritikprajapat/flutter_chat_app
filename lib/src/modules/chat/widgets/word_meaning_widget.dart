import '../../../app/app.dart';

class WordMeaningWidget extends StatelessWidget {
  final String word;
  const WordMeaningWidget({super.key, required this.word});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatViewModel>(
      builder: (context, chatViewModel, child) {
        return Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1E1B4B), Color(0xFF312E81)],
            ),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1), width: 1.5),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [_dragHandle(), _title(word), _content(chatViewModel)],
          ),
        );
      },
    );
  }

  Widget _dragHandle() {
    return Center(
      child: Container(
        width: 50,
        height: 5,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)]),
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }

  Widget _title(String word) {
    return Text(
      word,
      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }

  Widget _content(ChatViewModel vm) {
    if (vm.isMeaningLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: CircularProgressIndicator(color: Color(0xFF6366F1)),
        ),
      );
    }
    return Text(
      vm.meaning ?? 'No definition available',
      style: TextStyle(fontSize: 16, height: 1.6, color: Colors.white.withValues(alpha: 0.8)),
    );
  }
}
