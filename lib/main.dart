import 'package:flutter/material.dart';
import 'package:follower_for_tik_likes_views/Screens/repository/order_repository.dart';
import 'package:follower_for_tik_likes_views/Screens/repository/theme_repository.dart';
import 'package:follower_for_tik_likes_views/Screens/repository/user_repository.dart';
import 'package:follower_for_tik_likes_views/Screens/repository/wallet_repository.dart';
import 'package:follower_for_tik_likes_views/core/router/app_routes.dart';
import 'package:follower_for_tik_likes_views/provider/order_Provider.dart';
import 'package:follower_for_tik_likes_views/provider/theme_provider.dart';
import 'package:follower_for_tik_likes_views/provider/user_provider.dart';
import 'package:follower_for_tik_likes_views/provider/wallet_provider.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => OrderProvider(OrderRepository()),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(UserRepository()),
        ),
        ChangeNotifierProvider(
          create: (_) => WalletProvider(WalletRepository()),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(ThemeRepository()),
        ),
      ],
      child: const TrendSparkApp(),
    ),
  );
}

class TrendSparkApp extends StatelessWidget {
  const TrendSparkApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeProvider>().themeMode;

    return MaterialApp(
      title: 'TrendSpark',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: RouteGenerator.generate,
    );
  }
}
