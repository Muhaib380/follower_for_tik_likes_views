import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:follower_for_tik_likes_views/core/constants/app_colors.dart';
import 'package:follower_for_tik_likes_views/models/pakages_model.dart';

/// "Where should we deliver?" field shown on the Payment screen.
/// - Followers: asks for the TikTok username
/// - Likes / Views: asks for the TikTok video link
class OrderTargetField extends StatelessWidget {
  final PackageType type;
  final TextEditingController controller;

  const OrderTargetField({
    super.key,
    required this.type,
    required this.controller,
  });

  bool get _isUsername => type == PackageType.followers;

  /// Cleans the raw text before it is saved with the order.
  /// Username: removes spaces and a leading "@". Link: removes spaces.
  static String normalize(PackageType type, String raw) {
    final text = raw.trim();
    return type == PackageType.followers ? text.replaceFirst('@', '') : text;
  }

  String? _validate(String? value) {
    final text = normalize(type, value ?? '');

    if (_isUsername) {
      if (text.isEmpty) return 'Enter your TikTok username';
      if (!RegExp(r'^[A-Za-z0-9_.]{2,24}$').hasMatch(text)) {
        return '2 to 24 characters: letters, numbers, _ and .';
      }
      return null;
    }

    // Video link
    if (text.isEmpty) return 'Paste the link of your TikTok video';
    final uri = Uri.tryParse(text);
    final host = uri?.host.toLowerCase() ?? '';
    final isTiktok = host == 'tiktok.com' || host.endsWith('.tiktok.com');
    if (uri == null || !uri.hasScheme || !isTiktok) {
      return 'Enter a valid TikTok video link';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _isUsername ? 'TikTok Username' : 'TikTok Video Link',
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: controller,
          validator: _validate,
          keyboardType: _isUsername ? TextInputType.text : TextInputType.url,
          textInputAction: TextInputAction.done,
          inputFormatters: _isUsername
              ? [FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9_.@]'))]
              : null,
          style: theme.textTheme.bodyLarge?.copyWith(fontSize: 14.5),
          decoration: InputDecoration(
            hintText: _isUsername
                ? 'username'
                : 'https://www.tiktok.com/@user/video/...',
            prefixText: _isUsername ? '@' : null,
            prefixIcon: _isUsername ? null : const Icon(Icons.link_rounded, size: 20),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            _isUsername
                ? 'Your TikTok profile must be public.'
                : 'Open the video in TikTok, tap Share, then Copy link.',
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}