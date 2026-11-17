import 'package:flutter/material.dart';
import 'package:follower_for_tik_likes_views/core/constants/app_colors.dart';

/// A titled section (e.g. "Account") with a card that holds its rows.
class SettingsSection extends StatelessWidget {
  final String? title; // optional: no label is shown when null
  final List<Widget> children;

  const SettingsSection({
    super.key,
    this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 10),
            child: Text(
              title!,
              style: const TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        Container(
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
          child: Column(
            children: List.generate(children.length, (i) {
              return Column(
                children: [
                  children[i],
                  if (i != children.length - 1)
                    Divider(
                      height: 1,
                      indent: 54,
                      endIndent: 16,
                      color: theme.dividerColor,
                    ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}

/// One row: icon, title and (chevron | value + chevron | custom trailing like a Switch).
class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final String? value;      // e.g. "English"
  final Widget? trailing;   // e.g. a Switch. Replaces the chevron when given.

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.value,
    this.trailing,
  });

  static const _iconColor = Color(0xFF5F6690);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        // Rows with a Switch are already tall, so use less vertical padding.
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: trailing != null ? 6 : 15,
        ),
        child: Row(
          children: [
            Icon(icon, color: _iconColor, size: 22),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: theme.textTheme.bodyLarge?.color,
                ),
              ),
            ),
            if (value != null) ...[
              Text(
                value!,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: 4),
            ],
            trailing ??
                const Icon(Icons.chevron_right_rounded,
                    color: _iconColor, size: 24),
          ],
        ),
      ),
    );
  }
}