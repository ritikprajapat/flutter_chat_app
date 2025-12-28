import '../../../app/app.dart';

class ChatViewModel with ChangeNotifier {
  final Map<String, List<Message>> _userMessages = {};
  final List<ChatHistory> _chatHistories = [];

  final textController = TextEditingController();
  final scrollController = ScrollController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _meaning;
  bool _isMeaningLoading = false;

  String? get meaning => _meaning;
  bool get isMeaningLoading => _isMeaningLoading;

  List<ChatHistory> get chatHistories => _chatHistories;
  List<Message> messagesFor(String userId) => _userMessages[userId] ?? [];

  ChatViewModel() {
    _chatHistories.addAll([
      ChatHistory(
        id: '1',
        user: User(id: '1', name: 'Alice Johnson', isOnline: true),
        lastMessage: 'See you tomorrow!',
        lastChatTime: DateTime.now().subtract(const Duration(minutes: 2)),
        unreadCount: 2,
      ),
      ChatHistory(
        id: '2',
        user: User(id: '2', name: 'Bob Smith', isOnline: false),
        lastMessage: 'Thanks for the help',
        lastChatTime: DateTime.now().subtract(const Duration(minutes: 10)),
      ),
    ]);
  }

  void _addMessage(String userId, Message message) {
    _userMessages.putIfAbsent(userId, () => []);
    _userMessages[userId]!.add(message);
    notifyListeners();
    _scrollToBottom();
  }

  void _updateChatHistory(User user, String lastMessage) {
    _chatHistories.removeWhere((c) => c.user.id == user.id);
    _chatHistories.insert(
      0,
      ChatHistory(id: user.id, user: user, lastMessage: lastMessage, lastChatTime: DateTime.now()),
    );
    notifyListeners();
  }

  Future<void> sendMessage(User user) async {
    final text = textController.text.trim();
    if (text.isEmpty) return;

    textController.clear();

    final senderMsg = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      isSender: true,
      timestamp: DateTime.now(),
      userInitial: 'Y',
    );

    _addMessage(user.id, senderMsg);
    _updateChatHistory(user, text);

    _isLoading = true;
    notifyListeners();

    try {
      final apiText = await ApiService.fetchRandomMessage();

      final receiverMsg = Message(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: apiText,
        isSender: false,
        timestamp: DateTime.now(),
        userInitial: user.initial,
      );

      _addMessage(user.id, receiverMsg);
      _updateChatHistory(user, apiText);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (!scrollController.hasClients) return;
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  String? extractMeaningWord(String message) {
    final word = message.split(' ').first.replaceAll(RegExp(r'[^\w\s]'), '').toLowerCase();

    return word.length > 2 ? word : null;
  }

  Future<void> fetchWordMeaning(String word) async {
    _meaning = null;
    _isMeaningLoading = true;
    notifyListeners();

    try {
      _meaning = await ApiService.fetchWordMeaning(word);
    } catch (_) {
      _meaning = 'Failed to fetch meaning';
    }

    _isMeaningLoading = false;
    notifyListeners();
  }

  void onChatHistoryLongPress({required BuildContext context, required String message}) {
    final word = extractMeaningWord(message);
    if (word == null) return;

    fetchWordMeaning(word);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => WordMeaningWidget(word: word),
    );
  }

  @override
  void dispose() {
    textController.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
