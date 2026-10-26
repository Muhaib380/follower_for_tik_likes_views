import 'package:flutter/material.dart';
import 'package:follower_for_tik_likes_views/Screens/settings/setting_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // These two values live only in this screen for now.
  // TODO: Move them to a SettingsProvider / ThemeProvider and persist them.
  bool _notifications = true;
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------- Header ----------
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

              // ---------- Account ----------
              SettingsSection(
                title: 'Account',
                children: [
                  SettingsTile(
                    icon: Icons.lock_outline_rounded,
                    title: 'Change Password',
                    // TODO: Open the Change Password screen once it is built.
                    onTap: () {},
                  ),
                  SettingsTile(
                    icon: Icons.notifications_rounded,
                    title: 'Notifications',
                    trailing: Switch(
                      value: _notifications,
                      onChanged: (v) => setState(() => _notifications = v),
                    ),
                    onTap: () =>
                        setState(() => _notifications = !_notifications),
                  ),
                ],
              ),
              const SizedBox(height: 22),

              // ---------- App Settings ----------
              SettingsSection(
                title: 'App Settings',
                children: [
                  SettingsTile(
                    icon: Icons.nightlight_round,
                    title: 'Dark Mode',
                    // TODO: Connect this to a ThemeProvider so the whole app
                    // switches to AppTheme.dark. Right now it only moves the switch.
                    trailing: Switch(
                      value: _darkMode,
                      onChanged: (v) => setState(() => _darkMode = v),
                    ),
                    onTap: () => setState(() => _darkMode = !_darkMode),
                  ),
                  SettingsTile(
                    icon: Icons.translate_rounded,
                    title: 'Language',
                    value: 'English',
                    // TODO: Show a language picker once more languages exist.
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 22),

              // ---------- About ----------
              SettingsSection(
                title: 'About',
                children: [
                  SettingsTile(
                    icon: Icons.star_outline_rounded,
                    title: 'Rate Us',
                    // TODO: Open the Play Store / App Store page of the app.
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}