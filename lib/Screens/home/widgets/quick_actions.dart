import 'package:flutter/material.dart';
import 'package:follower_for_tik_likes_views/core/constants/app_colors.dart';

/// Get Followers / Get Likes / Get Views / More (Soft & Light pastel style).
class QuickActions extends StatelessWidget {
  final VoidCallback? onFollowers;
  final VoidCallback? onLikes;
  final VoidCallback? onViews;
  final VoidCallback? onMore;

  const QuickActions({
    super.key,
    this.onFollowers,
    this.onLikes,
    this.onViews,
    this.onMore,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _QuickActionItem(
          label: 'Get\nFollowers',
          icon: Icons.person_rounded,
          iconColor: AppColors.primary,
          backgroundColor: const Color(0xFFEDE9FE),
          onTap: onFollowers,
        ),
        _QuickActionItem(
          label: 'Get\nLikes',
          icon: Icons.favorite_rounded,
          iconColor: const Color(0xFFFF3B69),
          backgroundColor: const Color(0xFFFFE4EB),
          onTap: onLikes,
        ),
        _QuickActionItem(
          label: 'Get\nViews',
          icon: Icons.play_arrow_rounded,
          iconColor: const Color(0xFF0284C7),
          backgroundColor: const Color(0xFFE0F2FE),
          onTap: onViews,
        ),
        _QuickActionItem(
          label: 'More',
          icon: Icons.more_horiz_rounded,
          iconColor: AppColors.primary,
          backgroundColor: const Color(0xFFEDE9FE),
          onTap: onMore,
        ),
      ],
    );
  }
}

class _QuickActionItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final VoidCallback? onTap;

  const _QuickActionItem({
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 72,
        child: Column(
          children: [
            Container(
              height: 62,
              width: 62,
              decoration: BoxDecoration(
                color: backgroundColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: iconColor.withOpacity(0.12),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Icon(icon, color: iconColor, size: 28),
              ),
            ),
            const SizedBox(height: 9),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                height: 1.25,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
