import 'package:flutter/material.dart';
import 'package:follower_for_tik_likes_views/Screens/profile/contact_support.dart';
import 'package:follower_for_tik_likes_views/Screens/profile/profile_Header.dart';
import 'package:follower_for_tik_likes_views/Screens/profile/profile_menu_card.dart';
import 'package:follower_for_tik_likes_views/Screens/profile/tiktok_username_dialog.dart';
import 'package:follower_for_tik_likes_views/Screens/settings/setting_content.dart';
import 'package:follower_for_tik_likes_views/core/router/app_routes.dart';
import 'package:follower_for_tik_likes_views/provider/auth_provider.dart';
import 'package:follower_for_tik_likes_views/provider/user_provider.dart';
import 'package:provider/provider.dart';

/// "Profile" tab of the bottom navigation.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> _editTiktok() async {
    final userProvider = context.read<UserProvider>();
    final current = userProvider.tiktokUsername;

    final result = await showDialog<String>(
      context: context,
      builder: (_) => TiktokUsernameDialog(initial: current),
    );
    if (result == null || !mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Fetching TikTok profile for @$result...'),
        duration: const Duration(seconds: 2),
      ),
    );

    await userProvider.setTiktokUsername(result);
    if (!mounted) return;

    if (userProvider.avatarUrl != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('TikTok profile updated: @$result'),
          backgroundColor: const Color(0xFF10B981),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('TikTok account linked: @$result')),
      );
    }
  }

  Future<void> _logout() async {
    const red = Color(0xFFE5484D);

    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        final theme = Theme.of(ctx);
        return Dialog(
          backgroundColor: theme.colorScheme.surface,
          insetPadding: const EdgeInsets.symmetric(horizontal: 32),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 76,
                  width: 76,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFE3E6),
                    shape: BoxShape.circle,
                  ),
                  child:
                      const Icon(Icons.logout_rounded, color: red, size: 36),
                ),
                const SizedBox(height: 20),
                Text('Log Out',
                    style: theme.textTheme.titleLarge?.copyWith(fontSize: 22)),
                const SizedBox(height: 8),
                Text(
                  'Are you sure you want to log out of your account?',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(fontSize: 14, height: 1.45),
                ),
                const SizedBox(height: 26),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(0, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                        ),
                        onPressed: () => Navigator.pop(ctx, false),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: red,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(0, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                        ),
                        onPressed: () => Navigator.pop(ctx, true),
                        child: const Text('Log Out'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
    if (confirm != true || !mounted) return;

    // Clear session in AuthProvider
    await context.read<AuthProvider>().logout();

    if (!mounted) return;
    // Clear the whole navigation history and go to the Login screen.
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ---------- Part 1: top section ----------
            ProfileHeader(
              tiktokUsername: user.tiktokUsername,
              avatarUrl: user.avatarUrl,
              isFetching: user.isFetching,
              following: user.following,
              followers: user.followers,
              likes: user.likes,
              onTapTiktok: _editTiktok,
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ---------- Menu ----------
                  ProfileMenuCard(
                    items: [
                      ProfileMenuItem(
                        icon: Icons.account_balance_wallet_rounded,
                        title: 'Wallet & Payments',
                        onTap: () =>
                            Navigator.pushNamed(context, AppRoutes.wallet),
                      ),
                      ProfileMenuItem(
                        icon: Icons.info_rounded,
                        title: 'Help & Support',
                        onTap: () =>
                            Navigator.pushNamed(context, AppRoutes.support),
                      ),
                    ],
                  ),
                  const SizedBox(height: 26),

                  // ---------- Settings (inline) ----------
                  Text('Settings',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 14),
                  const SettingsContent(),
                  const SizedBox(height: 26),

                  // ---------- Log Out ----------
                  ProfileMenuCard(
                    items: [
                      ProfileMenuItem(
                        icon: Icons.logout_rounded,
                        title: 'Log Out',
                        onTap: _logout,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // ---------- Contact Support ----------
                  ContactSupportCard(
                    onTap: () =>
                        Navigator.pushNamed(context, AppRoutes.support),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
