import 'package:flutter/material.dart';
import 'package:follower_for_tik_likes_views/Screens/settings/setting_widget.dart';
import 'package:follower_for_tik_likes_views/core/constants/app_colors.dart';
import 'package:follower_for_tik_likes_views/provider/theme_provider.dart';
import 'package:provider/provider.dart';

/// The Account / App Settings / About sections.
/// Used inside the Profile screen (and by SettingsScreen).
class SettingsContent extends StatefulWidget {
  const SettingsContent({super.key});

  @override
  State<SettingsContent> createState() => _SettingsContentState();
}

class _SettingsContentState extends State<SettingsContent> {
  bool _notifications = true;
  String _language = 'English';

  void _showChangePasswordDialog() {
    final oldPassCtrl = TextEditingController();
    final newPassCtrl = TextEditingController();
    final confirmPassCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();
    bool obscureOld = true;
    bool obscureNew = true;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
          title: const Row(
            children: [
              Icon(Icons.lock_rounded, color: AppColors.primary),
              SizedBox(width: 10),
              Text('Change Password',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ],
          ),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: oldPassCtrl,
                    obscureText: obscureOld,
                    decoration: InputDecoration(
                      labelText: 'Current Password',
                      suffixIcon: IconButton(
                        icon: Icon(obscureOld
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () =>
                            setDialogState(() => obscureOld = !obscureOld),
                      ),
                    ),
                    validator: (v) => (v == null || v.isEmpty)
                        ? 'Enter current password'
                        : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: newPassCtrl,
                    obscureText: obscureNew,
                    decoration: InputDecoration(
                      labelText: 'New Password',
                      suffixIcon: IconButton(
                        icon: Icon(obscureNew
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () =>
                            setDialogState(() => obscureNew = !obscureNew),
                      ),
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Enter new password';
                      if (v.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: confirmPassCtrl,
                    obscureText: obscureNew,
                    decoration: const InputDecoration(
                      labelText: 'Confirm New Password',
                    ),
                    validator: (v) {
                      if (v != newPassCtrl.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Password changed successfully!'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguagePicker() {
    final languages = ['English', 'Urdu', 'Arabic', 'Spanish', 'Turkish'];

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Select Language',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(ctx),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ...languages.map(
              (lang) => ListTile(
                title: Text(lang),
                trailing: _language == lang
                    ? const Icon(Icons.check_circle_rounded,
                        color: AppColors.primary)
                    : null,
                onTap: () {
                  setState(() => _language = lang);
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Language changed to $lang'),
                      behavior: SnackBarBehavior.floating,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showRateUsDialog() {
    int rating = 5;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
          title: const Text('Rate TrendSpark',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'How is your experience with TrendSpark?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  final starIndex = index + 1;
                  return IconButton(
                    icon: Icon(
                      starIndex <= rating
                          ? Icons.star_rounded
                          : Icons.star_outline_rounded,
                      color: const Color(0xFFFFB800),
                      size: 34,
                    ),
                    onPressed: () =>
                        setDialogState(() => rating = starIndex),
                  );
                }),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Not now'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Thank you for your rating! ⭐'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final isDarkMode = themeProvider.isDarkMode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ---------- Account ----------
        SettingsSection(
          children: [
            SettingsTile(
              icon: Icons.lock_outline_rounded,
              title: 'Change Password',
              onTap: _showChangePasswordDialog,
            ),
            SettingsTile(
              icon: Icons.notifications_rounded,
              title: 'Notifications',
              trailing: Switch(
                value: _notifications,
                activeTrackColor: AppColors.primary,
                inactiveTrackColor: isDarkMode
                    ? const Color(0xFF3A2D7A)
                    : const Color(0xFFD4D0EC),
                thumbColor: WidgetStateProperty.all(Colors.white),
                trackOutlineColor:
                    WidgetStateProperty.all(Colors.transparent),
                onChanged: (v) {
                  setState(() => _notifications = v);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(v
                          ? 'Notifications turned on'
                          : 'Notifications turned off'),
                      behavior: SnackBarBehavior.floating,
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              ),
              onTap: () {
                final newValue = !_notifications;
                setState(() => _notifications = newValue);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(newValue
                        ? 'Notifications turned on'
                        : 'Notifications turned off'),
                    behavior: SnackBarBehavior.floating,
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 14),

        // ---------- App settings ----------
        SettingsSection(
          children: [
            SettingsTile(
              icon: Icons.nightlight_round,
              title: 'Dark Mode',
              trailing: Switch(
                value: isDarkMode,
                activeTrackColor: AppColors.primary,
                inactiveTrackColor: isDarkMode
                    ? const Color(0xFF3A2D7A)
                    : const Color(0xFFD4D0EC),
                thumbColor: WidgetStateProperty.all(Colors.white),
                trackOutlineColor:
                    WidgetStateProperty.all(Colors.transparent),
                onChanged: (v) =>
                    context.read<ThemeProvider>().toggleTheme(v),
              ),
              onTap: () =>
                  context.read<ThemeProvider>().toggleTheme(!isDarkMode),
            ),
            SettingsTile(
              icon: Icons.translate_rounded,
              title: 'Language',
              value: _language,
              onTap: _showLanguagePicker,
            ),
          ],
        ),
        const SizedBox(height: 14),

        // ---------- About ----------
        SettingsSection(
          children: [
            SettingsTile(
              icon: Icons.star_outline_rounded,
              title: 'Rate Us',
              onTap: _showRateUsDialog,
            ),
          ],
        ),
      ],
    );
  }
}
