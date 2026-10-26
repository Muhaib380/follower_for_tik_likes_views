import 'package:flutter/material.dart';
import 'package:follower_for_tik_likes_views/core/constants/app_colors.dart';
import 'package:follower_for_tik_likes_views/core/models/order_model.dart';
import 'package:follower_for_tik_likes_views/models/pakages_model.dart';

/// Orders list ki ek card: icon, package, date, price aur status chip.
class OrderCard extends StatelessWidget {
  final OrderModel order;

  const OrderCard({super.key, required this.order});

  IconData get _icon => switch (order.package.type) {
    PackageType.followers => Icons.person_rounded,
    PackageType.likes => Icons.favorite_rounded,
    PackageType.views => Icons.play_arrow_rounded,
  };

  bool get _isLikes => order.package.type == PackageType.likes;

  // Status ke rang
  Color get _chipBg => switch (order.status) {
    OrderStatus.processing => const Color(0xFFE9E4FF),
    OrderStatus.completed => const Color(0xFFDDF5E6),
    OrderStatus.canceled => const Color(0xFFFFE4E8),
  };

  Color get _chipText => switch (order.status) {
    OrderStatus.processing => AppColors.primary,
    OrderStatus.completed => const Color(0xFF1E9E57),
    OrderStatus.canceled => const Color(0xFFE5484D),
  };

  Color get _priceColor => switch (order.status) {
    OrderStatus.processing => AppColors.primary,
    OrderStatus.completed => const Color(0xFF1E9E57),
    OrderStatus.canceled => AppColors.textSecondary,
  };

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
            decoration: BoxDecoration(
              color: _isLikes
                  ? const Color(0xFFFFE3EA)
                  : AppColors.chipBackground,
              shape: BoxShape.circle,
            ),
            child: Icon(
              _icon,
              size: 28,
              color: _isLikes ? const Color(0xFFFF4D6D) : AppColors.primary,
            ),
          ),
          const SizedBox(width: 14),

          // Title, subtitle, date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.package.title,
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
                      fontSize: 12.5, color: AppColors.textSecondary),
                ),
                const SizedBox(height: 4),
                Text(
                  order.dateLabel,
                  style: const TextStyle(
                      fontSize: 11, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Price + status chip
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                order.package.priceLabel,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _priceColor,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: _chipBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  order.statusLabel,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: _chipText,
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