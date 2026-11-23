import 'package:flutter/foundation.dart';
import 'package:follower_for_tik_likes_views/Screens/repository/user_repository.dart';
import 'package:follower_for_tik_likes_views/services/tiktok_service.dart';

/// Holds the user's TikTok username, real profile picture (avatar), and live stats.
/// When a username is saved, it automatically fetches real TikTok DP and followers count!
class UserProvider extends ChangeNotifier {
  final UserRepository _repo;

  UserProvider(this._repo) {
    load();
  }

  String? _tiktokUsername;
  String? _nickname;
  String? _avatarUrl;
  String _followers = '12.4K';
  String _following = '124';
  String _likes = '482';

  bool _isLoaded = false;
  bool _isFetching = false;

  String? get tiktokUsername => _tiktokUsername;
  String? get nickname => _nickname;
  String? get avatarUrl => _avatarUrl;
  String get followers => _followers;
  String get following => _following;
  String get likes => _likes;
  bool get hasTiktokUsername =>
      _tiktokUsername != null && _tiktokUsername!.trim().isNotEmpty;
  bool get isLoaded => _isLoaded;
  bool get isFetching => _isFetching;

  String get displayName {
    if (_nickname != null && _nickname!.trim().isNotEmpty) {
      return _nickname!;
    }
    if (_tiktokUsername != null && _tiktokUsername!.trim().isNotEmpty) {
      return _tiktokUsername!.startsWith('@')
          ? _tiktokUsername!.substring(1)
          : _tiktokUsername!;
    }
    return 'Friend';
  }

  Future<void> load() async {
    _tiktokUsername = await _repo.getTiktokUsername();
    _nickname = await _repo.getNickname();
    _avatarUrl = await _repo.getAvatarUrl();
    final savedFollowers = await _repo.getFollowers();
    final savedFollowing = await _repo.getFollowing();
    final savedLikes = await _repo.getLikes();

    if (savedFollowers != null) _followers = savedFollowers;
    if (savedFollowing != null) _following = savedFollowing;
    if (savedLikes != null) _likes = savedLikes;

    _isLoaded = true;
    notifyListeners();
  }

  /// Sets TikTok username and automatically fetches real DP and stats from TikTok!
  Future<void> setTiktokUsername(String username) async {
    final clean = username.trim().replaceAll('@', '');
    if (clean.isEmpty) return;

    _tiktokUsername = clean;
    _isFetching = true;
    notifyListeners();

    // 1) Fetch real live data from TikTok API
    final profile = await TikTokService.fetchProfile(clean);

    if (profile != null) {
      _avatarUrl = profile.avatarUrl;
      _nickname = profile.nickname;
      _followers = profile.followers;
      _following = profile.following;
      _likes = profile.likes;

      await _repo.saveTiktokProfile(
        username: clean,
        nickname: profile.nickname,
        avatarUrl: profile.avatarUrl,
        followers: profile.followers,
        following: profile.following,
        likes: profile.likes,
      );
    } else {
      // Fallback: save username so user can still proceed
      await _repo.saveTiktokUsername(clean);
    }

    _isFetching = false;
    notifyListeners();
  }

  Future<void> clearTiktokUsername() async {
    await _repo.clearTiktokUsername();
    _tiktokUsername = null;
    _nickname = null;
    _avatarUrl = null;
    _followers = '12.4K';
    _following = '124';
    _likes = '482';
    notifyListeners();
  }
}
