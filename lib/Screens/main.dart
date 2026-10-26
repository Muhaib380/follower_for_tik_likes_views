import 'package:flutter/material.dart';
import 'package:follower_for_tik_likes_views/Screens/home/homeScreen.dart';
import 'package:follower_for_tik_likes_views/Screens/orders/orderScreen.dart';
import 'package:follower_for_tik_likes_views/Screens/profile/profileScreen.dart';
import 'package:follower_for_tik_likes_views/shared/widgets/app_bottom_nav.dart';

/// Home / Orders / Profile ka container. '/main' route yahi kholta hai.
/// initialIndex: 0 = Home, 1 = Orders, 2 = Profile
class MainScreen extends StatefulWidget {
  final int initialIndex;

  const MainScreen({super.key, this.initialIndex = 0});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _index = widget.initialIndex;

  @override
  Widget build(BuildContext context) {
    // IndexedStack: tab badalne par har screen ki state (scroll wagera) bachi rehti hai.
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: [
          const HomeScreen(),
          // Orders ka back arrow Home tab par le jata hai
          OrdersScreen(onBack: () => setState(() => _index = 0)),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}

/// Jab tak asli screens nahi bantin.
class _Placeholder extends StatelessWidget {
  final String title;
  const _Placeholder({required this.title});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(child: Text('$title screen agle steps mein')),
    );
  }
}