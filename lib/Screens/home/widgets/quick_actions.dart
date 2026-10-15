import 'package:flutter/material.dart';
import 'package:follower_for_tik_likes_views/core/constants/app_colors.dart';

/// Get Followers / Get Likes / Get Views / More wali 4 icons ki row.
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
          circleColor: AppColors.chipBackground,
          onTap: onFollowers,
        ),
        _QuickActionItem(
          label: 'Get\nLikes',
          icon: Icons.favorite_rounded,
          iconColor: const Color(0xFFFF4D6D),
          circleColor: const Color(0xFFFFE3EA),
          onTap: onLikes,
        ),
        _QuickActionItem(
          label: 'Get\nViews',
          icon: Icons.play_arrow_rounded,
          iconColor: AppColors.primary,
          circleColor: AppColors.chipBackground,
          onTap: onViews,
        ),
        _QuickActionItem(
          label: 'More',
          icon: Icons.more_horiz_rounded,
          iconColor: AppColors.primary,
          circleColor: AppColors.chipBackground,
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
  final Color circleColor;
  final VoidCallback? onTap;

  const _QuickActionItem({
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.circleColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 70,
        child: Column(
          children: [
            Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                color: circleColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 30),
            ),
            const SizedBox(height: 8),
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