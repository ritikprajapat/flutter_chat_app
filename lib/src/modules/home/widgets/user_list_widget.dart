import '../../../app/app.dart';

class UsersListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const UsersListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, homeViewModel, child) {
        if (homeViewModel.users.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF6366F1).withValues(alpha: 0.2),
                        const Color(0xFF8B5CF6).withValues(alpha: 0.1),
                      ],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.people_outline_rounded, size: 60, color: Colors.white.withValues(alpha: 0.7)),
                ),
                const SizedBox(height: 24),
                Text(
                  'No users yet',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tap the button to add your first user',
                  style: TextStyle(fontSize: 15, color: Colors.white.withValues(alpha: 0.5)),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          controller: scrollController,
          padding: const EdgeInsets.all(20),
          itemCount: homeViewModel.users.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: UserTileWidget(user: homeViewModel.users[index]),
          ),
        );
      },
    );
  }
}
