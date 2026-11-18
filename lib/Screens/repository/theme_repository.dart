import 'package:shared_preferences/shared_preferences.dart';

/// Knows WHERE theme preference (dark/light) is stored.
/// Uses SharedPreferences so user's choice survives app restart.
class ThemeRepository {
  static const _key = 'is_dark_mode';

  Future<bool> getIsDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_key) ?? false;
  }

  Future<void> saveIsDarkMode(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, isDark);
  }
}
