import 'package:flutter/material.dart';
import 'package:follower_for_tik_likes_views/Screens/repository/theme_repository.dart';

/// Holds the theme state (light / dark) for the entire app.
/// Updates the MaterialApp automatically when toggled.
class ThemeProvider extends ChangeNotifier {
  final ThemeRepository _repo;

  ThemeProvider(this._repo) {
    load();
  }

  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  Future<void> load() async {
    final isDark = await _repo.getIsDarkMode();
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  Future<void> toggleTheme(bool isDark) async {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
    await _repo.saveIsDarkMode(isDark);
  }
}
