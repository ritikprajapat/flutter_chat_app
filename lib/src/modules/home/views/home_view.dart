import 'package:chat_application/src/core/widgets/tab_switcher_widget.dart';
import 'package:chat_application/src/modules/chat/views/chat_history_view.dart';
import 'package:chat_application/src/modules/home/view_models/home_view_model.dart';
import 'package:chat_application/src/modules/home/widgets/home_top_bar.dart';
import 'package:chat_application/src/modules/home/widgets/user_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/helpers/snack_bar_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late HomeViewModel vm;

  @override
  void initState() {
    super.initState();
    vm = context.read<HomeViewModel>();
    vm.init(this);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, homeViewModel, child) {
        return Scaffold(
          backgroundColor: const Color(0xFF0A0E27),
          body: Stack(
            children: [
              _background(),
              SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    HomeTopBar(
                      visible: homeViewModel.showAppBar,
                      child: TabSwitcherWidget(
                        selectedTab: homeViewModel.selectedTab,
                        onTabChanged: homeViewModel.changeTab,
                      ),
                    ),

                    Expanded(
                      child: IndexedStack(
                        index: homeViewModel.selectedTab,
                        children: [
                          UsersListWidget(scrollController: homeViewModel.usersScroll),
                          ChatHistoryList(scrollController: homeViewModel.historyScroll),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          floatingActionButton: ScaleTransition(
            scale: homeViewModel.fabController,
            child: homeViewModel.isUsersTab
                ? GradientFab(
                    onTap: () {
                      final name = homeViewModel.addRandomUser();
                      SnackBarHelper.success('User $name added successfully!');
                    },
                    icon: const Icon(Icons.person_add_rounded, size: 26),
                  )
                : null,
          ),
        );
      },
    );
  }

  Widget _background() {
    return Positioned.fill(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0A0E27), Color(0xFF1E1B4B), Color(0xFF312E81)],
          ),
        ),
      ),
    );
  }
}

class GradientFab extends StatelessWidget {
  final VoidCallback onTap;
  final Widget icon;

  const GradientFab({super.key, required this.onTap, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)]),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6366F1).withValues(alpha: 0.55),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: FloatingActionButton(onPressed: onTap, elevation: 0, backgroundColor: Colors.transparent, child: icon),
    );
  }
}
