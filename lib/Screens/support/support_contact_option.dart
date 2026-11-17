import 'package:flutter/material.dart';
import 'package:follower_for_tik_likes_views/core/constants/app_colors.dart';

/// Three tappable cards: Email, Live Chat and Call Us.
class SupportContactOptions extends StatelessWidget {
  final VoidCallback? onEmail;
  final VoidCallback? onChat;
  final VoidCallback? onCall;

  const SupportContactOptions({
    super.key,
    this.onEmail,
    this.onChat,
    this.onCall,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _OptionCard(
            icon: Icons.mail_rounded,
            label: 'Email',
            onTap: onEmail,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _OptionCard(
            icon: Icons.chat_bubble_rounded,
            label: 'Live Chat',
            onTap: onChat,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _OptionCard(
            icon: Icons.call_rounded,
            label: 'Call Us',
            onTap: onCall,
          ),
        ),
      ],
    );
  }
}

class _OptionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _OptionCard({required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: theme.dividerColor),
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
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                color: AppColors.chipBackground,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.primary, size: 24),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: theme.textTheme.bodyLarge?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}