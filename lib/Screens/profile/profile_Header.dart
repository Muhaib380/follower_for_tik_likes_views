import 'package:flutter/material.dart';
import 'package:follower_for_tik_likes_views/core/constants/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

/// Profile ka upar ka hissa: gradient, photo (TikTok DP), TikTok username, 3 stats.
class ProfileHeader extends StatelessWidget {
  final String? name;
  final String? tiktokUsername; // null = abhi link nahi hua
  final String? avatarUrl; // TikTok real DP url
  final bool isFetching; // true jab API se data load ho raha ho
  final String following;
  final String followers;
  final String likes;
  final VoidCallback? onTapTiktok; // photo ya username par tap

  const ProfileHeader({
    super.key,
    this.name,
    this.tiktokUsername,
    this.avatarUrl,
    this.isFetching = false,
    required this.following,
    required this.followers,
    required this.likes,
    this.onTapTiktok,
  });

  /// Opens the user's TikTok profile in the browser or TikTok app
  Future<void> _openTikTokProfile() async {
    if (tiktokUsername == null || tiktokUsername!.trim().isEmpty) return;
    final clean = tiktokUsername!.replaceAll('@', '').trim();
    final uri = Uri.parse('https://www.tiktok.com/@$clean');
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      // Fallback: platform browser mein kholein
      await launchUrl(uri, mode: LaunchMode.platformDefault);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final linked = tiktokUsername != null && tiktokUsername!.trim().isNotEmpty;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // 1) Upar ka gradient
        Container(
          width: double.infinity,
          height: 190,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF5B2EE0),
                Color(0xFF8A2BA6),
                Color(0xFFE63DB8),
              ],
            ),
          ),
        ),

        // 2) Rounded sheet: TikTok username, stats
        Padding(
          padding: const EdgeInsets.only(top: 150),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 66, 20, 16),
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(36)),
            ),
            child: Column(
              children: [
                // TikTok username / Link account (tap karke dialog khulta hai)
                GestureDetector(
                  onTap: onTapTiktok,
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: linked
                          ? Colors.transparent
                          : AppColors.chipBackground,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          linked
                              ? (tiktokUsername!.startsWith('@')
                                  ? tiktokUsername!
                                  : '@$tiktokUsername')
                              : 'Link TikTok Account',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: linked
                                ? theme.textTheme.headlineMedium?.color
                                : AppColors.primary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (isFetching)
                          const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.primary,
                            ),
                          )
                        else
                          Icon(
                            linked
                                ? Icons.edit_rounded
                                : Icons.add_link_rounded,
                            size: 18,
                            color: AppColors.primary,
                          ),
                      ],
                    ),
                  ),
                ),

                // TikTok par jaane ka button (sirf tab jab account linked ho)
                if (linked && !isFetching)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: GestureDetector(
                      onTap: _openTikTokProfile,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF010101), // TikTok black
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.open_in_new_rounded,
                                color: Colors.white, size: 13),
                            SizedBox(width: 5),
                            Text(
                              'View on TikTok',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                const SizedBox(height: 22),

                // Stats (real TikTok followers, following, likes)
                Row(
                  children: [
                    _Stat(value: following, label: 'Following'),
                    _Stat(value: followers, label: 'Followers'),
                    _Stat(value: likes, label: 'Likes'),
                  ],
                ),
              ],
            ),
          ),
        ),

        // 3) Photo (gradient aur sheet dono par overlap)
        Positioned(
          top: 70,
          left: 0,
          right: 0,
          child: Center(
            child: GestureDetector(
              onTap: onTapTiktok,
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: const Color(0xFFE6DEFF),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: isFetching
                      ? const Center(
                          child: SizedBox(
                            height: 28,
                            width: 28,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: AppColors.primary,
                            ),
                          ),
                        )
                      : (avatarUrl != null && avatarUrl!.trim().isNotEmpty)
                          ? Image.network(
                              avatarUrl!,
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                              loadingBuilder: (context, child, progress) {
                                if (progress == null) return child;
                                return const Center(
                                  child: SizedBox(
                                    height: 28,
                                    width: 28,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(
                                Icons.person_rounded,
                                size: 58,
                                color: Color(0xFF8E8BB0),
                              ),
                            )
                          : const Icon(
                              Icons.person_rounded,
                              size: 58,
                              color: Color(0xFF8E8BB0),
                            ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  final String value;
  final String label;
  const _Stat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: theme.textTheme.bodyLarge?.color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
                fontSize: 12, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
