import '../../../app/app.dart';

class UserTileWidget extends StatelessWidget {
  final User user;
  const UserTileWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1), width: 1),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 15, offset: const Offset(0, 5))],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChatView(user: user))),
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                GradientAvatarWidget(initial: user.initial, isOnline: user.isOnline, size: 56),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17, color: Colors.white),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              gradient: user.isOnline
                                  ? const LinearGradient(colors: [Color(0xFF10B981), Color(0xFF059669)])
                                  : null,
                              color: user.isOnline ? null : Colors.grey,
                              shape: BoxShape.circle,
                              boxShadow: user.isOnline
                                  ? [BoxShadow(color: const Color(0xFF10B981).withValues(alpha: 0.6), blurRadius: 8)]
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            user.isOnline ? 'Online' : 'Offline',
                            style: TextStyle(
                              color: user.isOnline ? const Color(0xFF10B981) : Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.white.withValues(alpha: 0.3)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
