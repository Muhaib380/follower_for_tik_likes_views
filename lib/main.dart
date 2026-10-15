import 'package:flutter/material.dart';
import 'package:follower_for_tik_likes_views/core/router/app_routes.dart';
import 'core/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TrendSparkApp());
}

class TrendSparkApp extends StatelessWidget {
  const TrendSparkApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Providers aate hi yahan MultiProvider se wrap karenge.
    return MaterialApp(
      title: 'TrendSpark',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: RouteGenerator.generate,
    );
  }
}