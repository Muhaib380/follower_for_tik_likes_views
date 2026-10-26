import 'package:flutter/material.dart';
import 'package:follower_for_tik_likes_views/core/constants/app_colors.dart';

/// Profile ka upar ka hissa: gradient, photo, naam, TikTok username, 3 stats.
class ProfileHeader extends StatelessWidget {
  final String name;
  final String? tiktokUsername; // null = abhi link nahi hua
  final String following;
  final String followers;
  final String likes;
  final VoidCallback? onTapTiktok; // photo ya username par tap

  const ProfileHeader({
    super.key,
    required this.name,
    required this.following,
    required this.followers,
    required this.likes,
    this.tiktokUsername,
    this.onTapTiktok,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final linked = tiktokUsername != null;

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

        // 2) Rounded white sheet: naam, username, stats
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
                Text(name, style: theme.textTheme.headlineMedium),
                const SizedBox(height: 6),

                // TikTok username (tap karke dialog khulta hai)
                GestureDetector(
                  onTap: onTapTiktok,
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 6),
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
                              ? '@$tiktokUsername'
                              : 'Link your TikTok account',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight:
                            linked ? FontWeight.w500 : FontWeight.w600,
                            color: linked
                                ? AppColors.textSecondary
                                : AppColors.primary,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Icon(
                          linked ? Icons.edit_rounded : Icons.add_link_rounded,
                          size: 16,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 22),

                // Stats
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
                // TODO: baad mein user ki asli photo
                child: const Icon(Icons.person_rounded,
                    size: 58, color: Color(0xFF8E8BB0)),
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