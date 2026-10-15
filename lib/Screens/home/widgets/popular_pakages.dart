import 'package:flutter/material.dart';
import 'package:follower_for_tik_likes_views/core/constants/app_colors.dart';

/// "Popular Packages" title, "See All >" aur 3 package cards.
class PopularPackages extends StatelessWidget {
  final VoidCallback? onSeeAll;

  const PopularPackages({super.key, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
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
        // Abhi dummy data. Baad mein PackageProvider se aayega.
        const Row(
          children: [
            Expanded(
              child: _PackageCard(
                icon: Icons.person_rounded,
                iconColor: AppColors.primary,
                circleColor: AppColors.chipBackground,
                quantity: '1000',
                label: 'Followers',
                price: '\$4.99',
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _PackageCard(
                icon: Icons.favorite_rounded,
                iconColor: Color(0xFFFF4D6D),
                circleColor: Color(0xFFFFE3EA),
                quantity: '500',
                label: 'Likes',
                price: '\$2.99',
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _PackageCard(
                icon: Icons.play_arrow_rounded,
                iconColor: AppColors.primary,
                circleColor: AppColors.chipBackground,
                quantity: '1000',
                label: 'Views',
                price: '\$3.99',
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
  final Color circleColor;
  final String quantity;
  final String label;
  final String price;

  const _PackageCard({
    required this.icon,
    required this.iconColor,
    required this.circleColor,
    required this.quantity,
    required this.label,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).dividerColor),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 52,
            width: 52,
            decoration: BoxDecoration(color: circleColor, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 26),
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
    );
  }
}