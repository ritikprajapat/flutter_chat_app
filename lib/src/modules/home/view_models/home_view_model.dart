import 'dart:math';
import 'package:flutter/material.dart';
import 'package:chat_application/src/data/models/user_model.dart';

class HomeViewModel extends ChangeNotifier {
  // UI State
  int selectedTab = 0;
  bool showAppBar = true;
  bool get isUsersTab => selectedTab == 0;

  // Controllers
  final ScrollController usersScroll = ScrollController();
  final ScrollController historyScroll = ScrollController();
  late AnimationController fabController;

  double _lastOffset = 0;

  // Init
  void init(TickerProvider vsync) {
    fabController = AnimationController(vsync: vsync, duration: const Duration(milliseconds: 300))..forward();

    usersScroll.addListener(_onScroll);
    historyScroll.addListener(_onScroll);
  }

  // Scroll logic
  void _onScroll() {
    final ctrl = selectedTab == 0 ? usersScroll : historyScroll;
    if (!ctrl.hasClients) return;

    if (ctrl.offset > _lastOffset && ctrl.offset > 20) {
      if (showAppBar) {
        showAppBar = false;
        notifyListeners();
      }
    } else if (ctrl.offset < _lastOffset - 5) {
      if (!showAppBar) {
        showAppBar = true;
        notifyListeners();
      }
    }
    _lastOffset = ctrl.offset;
  }

  // Tab change
  void changeTab(int index) {
    selectedTab = index;
    index == 0 ? fabController.forward() : fabController.reverse();
    notifyListeners();
  }

  // ---------------- USERS ----------------

  final List<User> _users = [
    User(id: '1', name: 'Alice Johnson', isOnline: true),
    User(id: '2', name: 'Bob Smith', isOnline: false),
    User(id: '3', name: 'Carol Williams', isOnline: true),
  ];

  List<User> get users => List.unmodifiable(_users);

  String addRandomUser() {
    final mockNames = [
      'John Doe',
      'Jane Smith',
      'Mike Johnson',
      'Sarah Williams',
      'Chris Brown',
      'Emily Davis',
      'Alex Wilson',
      'Maria Garcia',
    ];

    final name = mockNames[Random().nextInt(mockNames.length)];
    _users.insert(0, User(id: DateTime.now().millisecondsSinceEpoch.toString(), name: name, isOnline: true));
    notifyListeners();
    return name;
  }

  @override
  void dispose() {
    usersScroll.dispose();
    historyScroll.dispose();
    fabController.dispose();
    super.dispose();
  }
}
