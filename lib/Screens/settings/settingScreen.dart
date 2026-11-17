import 'package:flutter/material.dart';
import 'package:follower_for_tik_likes_views/Screens/settings/setting_content.dart';

/// Standalone Settings page. The same content is also shown inside
/// the Profile screen, so this page is optional.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(20),
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text('Settings',
                      style: Theme.of(context).textTheme.headlineMedium),
                ],
              ),
              const SizedBox(height: 18),
              const SettingsContent(),
            ],
          ),
        ),
      ),
    );
  }
}