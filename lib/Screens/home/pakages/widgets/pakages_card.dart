import 'package:flutter/material.dart';
import 'package:follower_for_tik_likes_views/core/constants/app_colors.dart';
import 'package:follower_for_tik_likes_views/models/pakages_model.dart';

/// Packages list ki ek row: icon, "100 Followers", "Real & Active", price, Buy.
class PackageCard extends StatelessWidget {
  final PackageModel package;
  final VoidCallback? onBuy;

  const PackageCard({super.key, required this.package, this.onBuy});

  IconData get _icon => switch (package.type) {
    PackageType.followers => Icons.person_rounded,
    PackageType.likes => Icons.favorite_rounded,
    PackageType.views => Icons.play_arrow_rounded,
  };

  Color get _iconColor => package.type == PackageType.likes
      ? const Color(0xFFFF4D6D)
      : AppColors.primary;

  Color get _circleColor => package.type == PackageType.likes
      ? const Color(0xFFFFE3EA)
      : AppColors.chipBackground;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: theme.dividerColor),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon circle
          Container(
            height: 56,
            width: 56,
            decoration:
            BoxDecoration(color: _circleColor, shape: BoxShape.circle),
            child: Icon(_icon, color: _iconColor, size: 28),
          ),
          const SizedBox(width: 14),

          // Title + subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  package.title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Real & Active',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // Price + Buy
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                package.priceLabel,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: onBuy,
                child: Container(
                  height: 30,
                  width: 62,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Buy',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}