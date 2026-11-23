import 'package:shared_preferences/shared_preferences.dart';

/// Knows WHERE user data is stored.
/// Persists TikTok username, profile picture (avatar), and stats in SharedPreferences.
class UserRepository {
  static const _tiktokKey = 'tiktok_username';
  static const _avatarKey = 'tiktok_avatar_url';
  static const _followersKey = 'tiktok_followers';
  static const _followingKey = 'tiktok_following';
  static const _likesKey = 'tiktok_likes';
  static const _nicknameKey = 'tiktok_nickname';

  Future<String?> getTiktokUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tiktokKey);
  }

  Future<String?> getAvatarUrl() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_avatarKey);
  }

  Future<String?> getFollowers() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_followersKey);
  }

  Future<String?> getFollowing() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_followingKey);
  }

  Future<String?> getLikes() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_likesKey);
  }

  Future<String?> getNickname() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_nicknameKey);
  }

  Future<void> saveTiktokProfile({
    required String username,
    String? nickname,
    String? avatarUrl,
    String? followers,
    String? following,
    String? likes,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tiktokKey, username);
    if (nickname != null) await prefs.setString(_nicknameKey, nickname);
    if (avatarUrl != null) await prefs.setString(_avatarKey, avatarUrl);
    if (followers != null) await prefs.setString(_followersKey, followers);
    if (following != null) await prefs.setString(_followingKey, following);
    if (likes != null) await prefs.setString(_likesKey, likes);
  }

  Future<void> saveTiktokUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tiktokKey, username);
  }

  Future<void> clearTiktokUsername() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tiktokKey);
    await prefs.remove(_avatarKey);
    await prefs.remove(_followersKey);
    await prefs.remove(_followingKey);
    await prefs.remove(_likesKey);
    await prefs.remove(_nicknameKey);
  }
}
