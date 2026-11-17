import 'package:flutter/foundation.dart';
import 'package:follower_for_tik_likes_views/Screens/order_repository/user_repository.dart';

/// Holds the user's TikTok username for the whole app.
/// The Profile screen (and later the Payment screen) read it from here,
/// so both always show the same value.
class UserProvider extends ChangeNotifier {
  final UserRepository _repo;

  UserProvider(this._repo) {
    load(); // read the saved username as soon as the provider is created
  }

  String? _tiktokUsername; // null = not linked yet
  bool _isLoaded = false;

  String? get tiktokUsername => _tiktokUsername;
  bool get hasTiktokUsername => _tiktokUsername != null;
  bool get isLoaded => _isLoaded;

  Future<void> load() async {
    _tiktokUsername = await _repo.getTiktokUsername();
    _isLoaded = true;
    notifyListeners();
  }

  Future<void> setTiktokUsername(String username) async {
    await _repo.saveTiktokUsername(username);
    _tiktokUsername = username;
    notifyListeners(); // every screen showing the username updates
  }

  Future<void> clearTiktokUsername() async {
    await _repo.clearTiktokUsername();
    _tiktokUsername = null;
    notifyListeners();
  }
}