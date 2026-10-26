import 'package:flutter/material.dart';
import 'package:follower_for_tik_likes_views/Screens/auth/loginScreen.dart';
import 'package:follower_for_tik_likes_views/Screens/auth/registrationScreen.dart';
import 'package:follower_for_tik_likes_views/Screens/home/homeScreen.dart';
import 'package:follower_for_tik_likes_views/Screens/home/pakages/pakages_screen.dart';
import 'package:follower_for_tik_likes_views/Screens/home/wallet/wallet_screen.dart';
import 'package:follower_for_tik_likes_views/Screens/main.dart';
import 'package:follower_for_tik_likes_views/Screens/onboarding/onbaordingScreens.dart';
import 'package:follower_for_tik_likes_views/Screens/payment/order_success_Screen.dart';
import 'package:follower_for_tik_likes_views/Screens/payment/paymentScreen.dart';
import 'package:follower_for_tik_likes_views/Screens/settings/settingScreen.dart';
import 'package:follower_for_tik_likes_views/Screens/splash/splashScreen.dart';
import 'package:follower_for_tik_likes_views/models/pakages_model.dart';

class AppRoutes {
  AppRoutes._();

  static const splash = '/';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const register = '/register';
  static const main = '/main'; // bottom nav (Home / Orders / Profile)
  static const packages = '/packages';
  static const wallet = '/wallet';
  static const payment = '/payment';
  static const orderSuccess = '/order-success';
  static const settings = '/settings';
  static const support = '/support';
}

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic> generate(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return _page(const SplashScreen(), settings);
      case AppRoutes.onboarding:
        return _page(const OnboardingScreen(), settings);
      case AppRoutes.login:
        return _page(const LoginScreen(), settings);
      case AppRoutes.register:
        return _page(const RegisterScreen(), settings);
      case AppRoutes.main:
        final index = settings.arguments as int? ?? 0;
        return _page(MainScreen(initialIndex: index), settings);
      case AppRoutes.packages:
        final tab = settings.arguments as int? ?? 0;
        return _page(PackagesScreen(initialTab: tab), settings);
      case AppRoutes.wallet:
        return _page(const WalletScreen(), settings);
      case AppRoutes.payment:
        final package = settings.arguments as PackageModel;
        return _page(PaymentScreen(package: package), settings);
      case AppRoutes.orderSuccess:
        final package = settings.arguments as PackageModel;
        return _page(OrderSuccessScreen(package: package), settings);
      case AppRoutes.settings:
        return _page(const SettingsScreen(), settings);

      default:
        return _page(_Placeholder(name: settings.name ?? 'unknown'), settings);
    }
  }

  // ignore: unused_element
  static MaterialPageRoute _page(Widget child, RouteSettings settings) =>
      MaterialPageRoute(builder: (_) => child, settings: settings);
}

/// Temporary screen jab tak asli screens nahi bante.
class _Placeholder extends StatelessWidget {
  final String name;
  const _Placeholder({required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Screen: $name')));
  }
}