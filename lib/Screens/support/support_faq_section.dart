import 'package:flutter/material.dart';
import 'package:follower_for_tik_likes_views/core/constants/app_colors.dart';

class FaqItem {
  final String question;
  final String answer;
  const FaqItem(this.question, this.answer);
}

/// Expandable list of frequently asked questions. One answer is open at a time.
class SupportFaqSection extends StatefulWidget {
  const SupportFaqSection({super.key});

  @override
  State<SupportFaqSection> createState() => _SupportFaqSectionState();
}

class _SupportFaqSectionState extends State<SupportFaqSection> {
  // TODO: These are sample answers. Replace them with your real policies
  // (delivery time, refunds, etc.) before the app is released.
  static const _faqs = [
    FaqItem(
      'How long does an order take?',
      'Most orders start within a few hours. Larger packages can take longer. '
          'You can follow the progress in the Orders tab.',
    ),
    FaqItem(
      'Do you need my TikTok password?',
      'No. We never ask for your password. We only need your public TikTok '
          'username. Never share your password with anyone.',
    ),
    FaqItem(
      'Why does my profile need to be public?',
      'We can only deliver to public profiles. If your profile is private, '
          'the order cannot be completed.',
    ),
    FaqItem(
      'What do Processing, Completed and Canceled mean?',
      'Processing: your order has been received and is in progress. '
          'Completed: the order has been delivered. '
          'Canceled: the order could not be completed.',
    ),
    FaqItem(
      'How do I get a refund?',
      'If an order is canceled, the amount is returned to your wallet. '
          'Contact support if you think something is wrong with an order.',
    ),
    FaqItem(
      'Can I change my TikTok username?',
      'Yes. Open the Profile tab and tap your TikTok username to change it.',
    ),
  ];

  int? _open; // index of the open question, null if all are closed

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(_faqs.length, (i) {
        return Padding(
          padding: EdgeInsets.only(bottom: i == _faqs.length - 1 ? 0 : 10),
          child: _FaqTile(
            item: _faqs[i],
            open: _open == i,
            onTap: () => setState(() => _open = _open == i ? null : i),
          ),
        );
      }),
    );
  }
}

class _FaqTile extends StatelessWidget {
  final FaqItem item;
  final bool open;
  final VoidCallback onTap;

  const _FaqTile({
    required this.item,
    required this.open,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: open ? AppColors.primary.withOpacity(0.5) : theme.dividerColor,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeInOut,
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      item.question,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  AnimatedRotation(
                    turns: open ? 0.5 : 0,
                    duration: const Duration(milliseconds: 220),
                    child: const Icon(Icons.keyboard_arrow_down_rounded,
                        color: AppColors.primary, size: 26),
                  ),
                ],
              ),
              if (open) ...[
                const SizedBox(height: 10),
                Text(
                  item.answer,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}