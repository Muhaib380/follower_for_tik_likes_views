import 'package:flutter/material.dart';
import 'package:follower_for_tik_likes_views/core/constants/app_colors.dart';

/// Ek payment method ka data: id, naam, aap ki image ka path.
class PaymentMethodItem {
  final String id;
  final String name;
  final String imagePath;   // aap ki apni image
  final IconData fallbackIcon; // image na mile to ye icon dikhega

  const PaymentMethodItem({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.fallbackIcon,
  });
}

/// Payment method ki ek row: image, naam aur right par radio button.
class PaymentMethodTile extends StatelessWidget {
  final PaymentMethodItem method;
  final bool selected;
  final VoidCallback onTap;

  const PaymentMethodTile({
    super.key,
    required this.method,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
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
            // Aap ki image (na mile to fallback icon)
            SizedBox(
              height: 44,
              width: 44,
              child: Image.asset(
                method.imagePath,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => Icon(
                  method.fallbackIcon,
                  size: 30,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                method.name,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: theme.textTheme.bodyLarge?.color,
                ),
              ),
            ),
            _RadioDot(selected: selected),
          ],
        ),
      ),
    );
  }
}

class _RadioDot extends StatelessWidget {
  final bool selected;
  const _RadioDot({required this.selected});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      height: 22,
      width: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: selected ? AppColors.primary : const Color(0xFFC9C5E0),
          width: 2,
        ),
      ),
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          height: selected ? 10 : 0,
          width: selected ? 10 : 0,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}