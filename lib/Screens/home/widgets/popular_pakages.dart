import 'package:flutter/material.dart';
import 'package:follower_for_tik_likes_views/core/constants/app_colors.dart';
import 'package:follower_for_tik_likes_views/models/pakages_model.dart';

/// "Popular Packages" title, "See All >" aur 3 soft pastel package cards.
class PopularPackages extends StatelessWidget {
  final VoidCallback? onSeeAll;

  /// Called when a package card is tapped.
  /// tab: 0 = Followers, 1 = Likes, 2 = Views
  final ValueChanged<int>? onPackageTap;

  const PopularPackages({super.key, this.onSeeAll, this.onPackageTap});

  @override
  Widget build(BuildContext context) {
    // Single source of truth from PackageModel
    final popularFollowers = PackageModel.dummy.firstWhere(
      (p) => p.id == 'f3',
      orElse: () => const PackageModel(
          id: 'f3', type: PackageType.followers, quantity: 1000, price: 16.99),
    );
    final popularLikes = PackageModel.dummy.firstWhere(
      (p) => p.id == 'l2',
      orElse: () => const PackageModel(
          id: 'l2', type: PackageType.likes, quantity: 500, price: 2.99),
    );
    final popularViews = PackageModel.dummy.firstWhere(
      (p) => p.id == 'v2',
      orElse: () => const PackageModel(
          id: 'v2', type: PackageType.views, quantity: 1000, price: 3.99),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Popular Packages',
                style: Theme.of(context).textTheme.titleLarge),
            GestureDetector(
              onTap: onSeeAll,
              behavior: HitTestBehavior.opaque,
              child: const Row(
                children: [
                  Text(
                    'See All',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(Icons.chevron_right_rounded,
                      color: AppColors.primary, size: 20),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: _PackageCard(
                icon: Icons.person_rounded,
                iconColor: AppColors.primary,
                backgroundColor: const Color(0xFFEDE9FE),
                quantity: popularFollowers.quantityLabel,
                label: popularFollowers.typeName,
                onTap: () => onPackageTap?.call(0),
                price: popularFollowers.priceLabel,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _PackageCard(
                icon: Icons.favorite_rounded,
                iconColor: const Color(0xFFFF3B69),
                backgroundColor: const Color(0xFFFFE4EB),
                quantity: popularLikes.quantityLabel,
                label: popularLikes.typeName,
                onTap: () => onPackageTap?.call(1),
                price: popularLikes.priceLabel,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _PackageCard(
                icon: Icons.play_arrow_rounded,
                iconColor: const Color(0xFF0284C7),
                backgroundColor: const Color(0xFFE0F2FE),
                quantity: popularViews.quantityLabel,
                label: popularViews.typeName,
                onTap: () => onPackageTap?.call(2),
                price: popularViews.priceLabel,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PackageCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final String quantity;
  final String label;
  final String price;
  final VoidCallback? onTap;

  const _PackageCard({
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.quantity,
    required this.label,
    required this.price,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Theme.of(context).dividerColor),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.06),
              blurRadius: 14,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                color: backgroundColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(icon, color: iconColor, size: 26),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              quantity,
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w700, color: textColor),
            ),
            Text(
              label,
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w600, color: textColor),
            ),
            const SizedBox(height: 8),
            Text(
              price,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
