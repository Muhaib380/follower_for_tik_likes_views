import 'package:flutter/material.dart';
import 'package:follower_for_tik_likes_views/Screens/settings/setting_widget.dart';

/// The Account / App Settings / About sections.
/// Used inside the Profile screen (and by SettingsScreen).
class SettingsContent extends StatefulWidget {
  const SettingsContent({super.key});

  @override
  State<SettingsContent> createState() => _SettingsContentState();
}

class _SettingsContentState extends State<SettingsContent> {
  // These two values live only in this widget for now.
  // TODO: Move them to a SettingsProvider / ThemeProvider and persist them.
  bool _notifications = true;
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ---------- Account (no label) ----------
        SettingsSection(
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
              onTap: () => setState(() => _notifications = !_notifications),
            ),
          ],
        ),
        const SizedBox(height: 14),

        // ---------- App settings (no label) ----------
        SettingsSection(
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
        const SizedBox(height: 14),

        // ---------- About (no label) ----------
        SettingsSection(
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
    );
  }
}