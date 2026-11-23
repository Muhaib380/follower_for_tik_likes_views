import 'package:flutter/material.dart';
import 'package:follower_for_tik_likes_views/Screens/home/widgets/home_header.dart';
import 'package:follower_for_tik_likes_views/Screens/home/widgets/popular_pakages.dart';
import 'package:follower_for_tik_likes_views/Screens/home/widgets/quick_actions.dart';
import 'package:follower_for_tik_likes_views/Screens/home/widgets/total_followers_card.dart';
import 'package:follower_for_tik_likes_views/core/router/app_routes.dart';
import 'package:follower_for_tik_likes_views/provider/user_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Read user data dynamically from UserProvider
    final user = context.watch<UserProvider>();
    final displayName = user.displayName;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFF3A1C9E), // image load hone se pehle ka rang
          image: DecorationImage(
            image: AssetImage('assets/images/splash_back.png'),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              // ---------- Part 1: header + card ----------
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
                child: HomeHeader(name: displayName),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TotalFollowersCard(
                  count: user.followers,
                  growth: '+12%',
                ),
              ),
              const SizedBox(height: 24),

              // ---------- Part 2: neeche ka white sheet ----------
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(32)),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 26, 20, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // QuickActions: 4 realistic gradient icons
                        QuickActions(
                          // Get Followers -> Packages, tab 0 (Followers)
                          onFollowers: () => Navigator.pushNamed(
                              context, AppRoutes.packages,
                              arguments: 0),
                          // Get Likes -> Packages, tab 1 (Likes)
                          onLikes: () => Navigator.pushNamed(
                              context, AppRoutes.packages,
                              arguments: 1),
                          // Get Views -> Packages, tab 2 (Views)
                          onViews: () => Navigator.pushNamed(
                              context, AppRoutes.packages,
                              arguments: 2),
                          // More -> Packages screen
                          onMore: () => Navigator.pushNamed(
                              context, AppRoutes.packages,
                              arguments: 0),
                        ),
                        const SizedBox(height: 28),

                        // Popular Packages from PackageModel
                        PopularPackages(
                          onSeeAll: () => Navigator.pushNamed(
                              context, AppRoutes.packages,
                              arguments: 0),
                          onPackageTap: (tab) => Navigator.pushNamed(
                              context, AppRoutes.packages,
                              arguments: tab),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
