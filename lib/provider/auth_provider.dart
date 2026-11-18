import 'package:flutter/foundation.dart';
import 'package:follower_for_tik_likes_views/Screens/repository/auth_repository.dart';

/// Holds authentication state (logged in, onboarding seen, user session).
class AuthProvider extends ChangeNotifier {
  final AuthRepository _repo;

  AuthProvider(this._repo) {
    init();
  }

  bool _isLoggedIn = false;
  bool _hasSeenOnboarding = false;
  String? _email;
  String? _name;
  bool _isInitialized = false;

  bool get isLoggedIn => _isLoggedIn;
  bool get hasSeenOnboarding => _hasSeenOnboarding;
  String? get email => _email;
  String? get name => _name;
  bool get isInitialized => _isInitialized;

  Future<void> init() async {
    _isLoggedIn = await _repo.isLoggedIn();
    _hasSeenOnboarding = await _repo.hasSeenOnboarding();
    _email = await _repo.getUserEmail();
    _name = await _repo.getUserName();
    _isInitialized = true;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 600)); // simulates network
    _isLoggedIn = true;
    _email = email;
    await _repo.saveLogin(email: email);
    notifyListeners();
  }

  Future<void> register(String name, String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 600)); // simulates network
    _isLoggedIn = true;
    _name = name;
    _email = email;
    await _repo.saveLogin(email: email, name: name);
    notifyListeners();
  }

  Future<void> completeOnboarding() async {
    _hasSeenOnboarding = true;
    await _repo.setOnboardingSeen();
    notifyListeners();
  }

  Future<void> logout() async {
    _isLoggedIn = false;
    _email = null;
    _name = null;
    await _repo.logout();
    notifyListeners();
  }
}
