import 'package:flutter/material.dart';
import 'package:follower_for_tik_likes_views/Screens/profile/contact_support.dart';
import 'package:follower_for_tik_likes_views/Screens/profile/profile_Header.dart';
import 'package:follower_for_tik_likes_views/Screens/profile/profile_menu_card.dart';
import 'package:follower_for_tik_likes_views/Screens/profile/tiktok_username_diolog.dart';
import 'package:follower_for_tik_likes_views/core/router/app_routes.dart';

/// "Profile" tab of the bottom navigation.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Currently stored only in this screen's memory and is lost when the app closes.
  // TODO: Persist it later with shared_preferences / backend / provider.
  String? _tiktokUsername;

  Future<void> _editTiktok() async {
    final result = await showDialog<String>(
      context: context,
      builder: (_) => TiktokUsernameDialog(initial: _tiktokUsername),
    );
    if (result == null || !mounted) return;

    setState(() => _tiktokUsername = result);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('TikTok account linked: @$result')),
    );
  }

  Future<void> _logout() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
    if (confirm != true || !mounted) return;

    // TODO: Call AuthProvider.logout() once the provider is added.
    // Clear the whole navigation history and go to the Login screen.
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ---------- Part 1: top section ----------
            // Name and stats are dummy values for now.
            ProfileHeader(
              name: 'Muhib',
              tiktokUsername: _tiktokUsername,
              following: '124',
              followers: '12.4K',
              likes: '482',
              onTapTiktok: _editTiktok,
            ),

            // ---------- Part 2: menu + Contact Support ----------
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
              child: Column(
                children: [
                  ProfileMenuCard(
                    items: [
                      // ProfileMenuItem(
                      //   icon: Icons.edit_rounded,
                      //   title: 'Edit Profile',
                      //   // TODO: Open the Edit Profile screen once it is built.
                      //   onTap: () {},
                      // ),
                      ProfileMenuItem(
                        icon: Icons.account_balance_wallet_rounded,
                        title: 'Wallet & Payments',
                        onTap: () =>
                            Navigator.pushNamed(context, AppRoutes.wallet),
                      ),
                      ProfileMenuItem(
                        icon: Icons.settings_rounded,
                        title: 'Settings',
                        // TODO: The Settings screen is not built yet, so this
                        // currently opens the placeholder screen.
                        onTap: () =>
                            Navigator.pushNamed(context, AppRoutes.settings),
                      ),
                      ProfileMenuItem(
                        icon: Icons.info_rounded,
                        title: 'Help & Support',
                        // TODO: The Support screen is not built yet, so this
                        // currently opens the placeholder screen.
                        onTap: () =>
                            Navigator.pushNamed(context, AppRoutes.support),
                      ),
                      ProfileMenuItem(
                        icon: Icons.logout_rounded,
                        title: 'Log Out',
                        onTap: _logout,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ContactSupportCard(
                    // TODO: Support screen is not built yet (placeholder for now).
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