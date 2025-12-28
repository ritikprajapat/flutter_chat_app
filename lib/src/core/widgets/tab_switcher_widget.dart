import '../../app/app.dart';

class TabSwitcherWidget extends StatelessWidget {
  final int selectedTab;
  final ValueChanged<int> onTabChanged;

  const TabSwitcherWidget({super.key, required this.selectedTab, required this.onTabChanged});

  static const _height = 44.0;
  static const _animationDuration = Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(4),
      decoration: _outerDecoration,
      child: Stack(
        children: [
          _AnimatedBackground(selectedTab: selectedTab),
          Row(
            children: [
              _TabItem(title: 'Users', index: 0, selectedTab: selectedTab, onTap: onTabChanged),
              _TabItem(title: 'Chat History', index: 1, selectedTab: selectedTab, onTap: onTabChanged),
            ],
          ),
        ],
      ),
    );
  }
}

class _AnimatedBackground extends StatelessWidget {
  final int selectedTab;

  const _AnimatedBackground({required this.selectedTab});

  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      duration: TabSwitcherWidget._animationDuration,
      curve: Curves.easeInOutCubic,
      alignment: selectedTab == 0 ? Alignment.centerLeft : Alignment.centerRight,
      child: FractionallySizedBox(
        widthFactor: 0.5,
        child: Container(
          height: TabSwitcherWidget._height,
          margin: const EdgeInsets.all(2),
          decoration: _indicatorDecoration,
        ),
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String title;
  final int index;
  final int selectedTab;
  final ValueChanged<int> onTap;

  const _TabItem({required this.title, required this.index, required this.selectedTab, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        child: Container(
          height: TabSwitcherWidget._height,
          alignment: Alignment.center,
          color: Colors.transparent,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : Colors.white60,
            ),
          ),
        ),
      ),
    );
  }
}

final _outerDecoration = BoxDecoration(
  color: Colors.white.withValues(alpha: 0.05),
  borderRadius: BorderRadius.circular(30),
  border: Border.all(color: Colors.white.withValues(alpha: 0.1), width: 1.5),
  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 20, offset: const Offset(0, 8))],
);

final _indicatorDecoration = BoxDecoration(
  gradient: const LinearGradient(colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)]),
  borderRadius: BorderRadius.circular(26),
  boxShadow: [BoxShadow(color: Color(0xFF6366F1), blurRadius: 15, offset: Offset(0, 4))],
);
