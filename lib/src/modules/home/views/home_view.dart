import 'dart:math';

import 'package:chat_application/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  int _selectedTab = 0;
  final _usersScroll = ScrollController();
  final _historyScroll = ScrollController();
  bool _showAppBar = true;
  double _lastOffset = 0;
  late AnimationController _fabAnim;

  @override
  void initState() {
    super.initState();
    _usersScroll.addListener(_onScroll);
    _historyScroll.addListener(_onScroll);
    _fabAnim = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    _fabAnim.forward();
  }

  void _onScroll() {
    final ctrl = _selectedTab == 0 ? _usersScroll : _historyScroll;
    if (!ctrl.hasClients) return;

    if (ctrl.offset > _lastOffset && ctrl.offset > 20) {
      if (_showAppBar) setState(() => _showAppBar = false);
    } else if (ctrl.offset < _lastOffset - 5) {
      if (!_showAppBar) setState(() => _showAppBar = true);
    }
    _lastOffset = ctrl.offset;
  }

  @override
  void dispose() {
    _usersScroll.dispose();
    _historyScroll.dispose();
    _fabAnim.dispose();
    super.dispose();
  }

  void _showAddDialog() {
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
    final randomName = mockNames[Random().nextInt(mockNames.length)];

    context.read<UserProvider>().addUser(randomName);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF10B981), Color(0xFF059669)]),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 16),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text('$randomName added!', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: const Color(0xFF1F2937),
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFF0A0E27),
      body: Stack(
        children: [
          // Animated gradient background
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [const Color(0xFF0A0E27), const Color(0xFF1E1B4B), const Color(0xFF312E81)],
                ),
              ),
            ),
          ),
          // Floating orbs for depth
          Positioned(top: -100, right: -100, child: _buildOrb(300, const Color(0xFF6366F1))),
          Positioned(bottom: -150, left: -150, child: _buildOrb(400, const Color(0xFFEC4899))),

          // Main content
          SafeArea(
            child: Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  height: _showAppBar ? 120 : 0,
                  child: _showAppBar
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 16),
                            GlassSwitcher(
                              selectedTab: _selectedTab,
                              onTabChanged: (i) {
                                setState(() => _selectedTab = i);
                                i == 0 ? _fabAnim.forward() : _fabAnim.reverse();
                              },
                            ),
                          ],
                        )
                      : const SizedBox(),
                ),
                Expanded(
                  child: IndexedStack(
                    index: _selectedTab,
                    children: [
                      UsersList(scrollController: _usersScroll),
                      ChatHistoryList(scrollController: _historyScroll),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: ScaleTransition(
        scale: _fabAnim,
        child: _selectedTab == 0
            ? Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)]),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6366F1).withOpacity(0.5),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: FloatingActionButton.extended(
                  onPressed: _showAddDialog,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  icon: const Icon(Icons.person_add_rounded),
                  label: const Text('Add User', style: TextStyle(fontWeight: FontWeight.w600)),
                ),
              )
            : null,
      ),
      bottomNavigationBar: _buildGlassBottomNav(),
    );
  }

  Widget _buildOrb(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color.withOpacity(0.3), Colors.transparent]),
      ),
    );
  }

  Widget _buildGlassBottomNav() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1.5),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 30, offset: const Offset(0, 10))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home_rounded, 'Home', true),
          _buildNavItem(Icons.local_offer_rounded, 'Offers', false),
          _buildNavItem(Icons.settings_rounded, 'Settings', false),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        gradient: isActive ? const LinearGradient(colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)]) : null,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, color: isActive ? Colors.white : Colors.white60, size: 22),
          if (isActive) ...[
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ],
        ],
      ),
    );
  }
}
