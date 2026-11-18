import 'package:shared_preferences/shared_preferences.dart';

/// Knows WHERE user data is stored.
///
/// Right now it uses the phone's local storage (shared_preferences), so the
/// TikTok username survives an app restart. Later, when a backend exists,
/// only the code inside these methods changes. The provider and the screens
/// stay the same.
class UserRepository {
  static const _tiktokKey = 'tiktok_username';

  Future<String?> getTiktokUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tiktokKey);
  }

  Future<void> saveTiktokUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tiktokKey, username);
  }

  Future<void> clearTiktokUsername() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tiktokKey);
  }
}