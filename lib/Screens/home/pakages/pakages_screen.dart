import 'package:flutter/material.dart';
import 'package:follower_for_tik_likes_views/Screens/home/pakages/pakages_tab.dart';
import 'package:follower_for_tik_likes_views/Screens/home/pakages/widgets/pakages_card.dart';
import 'package:follower_for_tik_likes_views/core/router/app_routes.dart';
import 'package:follower_for_tik_likes_views/models/pakages_model.dart';

/// initialTab: 0 = Followers, 1 = Likes, 2 = Views
class PackagesScreen extends StatefulWidget {
  final int initialTab;

  const PackagesScreen({super.key, this.initialTab = 0});

  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  late int _tab = widget.initialTab;

  @override
  Widget build(BuildContext context) {
    // Selected tab ke hisaab se list (0 followers, 1 likes, 2 views)
    final packages = PackageModel.byType(PackageType.values[_tab]);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              // ---------- Header ----------
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(20),
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text('Packages',
                      style: Theme.of(context).textTheme.headlineMedium),
                ],
              ),
              const SizedBox(height: 18),

              // ---------- Tabs ----------
              PackageTabs(
                selectedIndex: _tab,
                onChanged: (i) => setState(() => _tab = i),
              ),
              const SizedBox(height: 16),

              // ---------- List ----------
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(bottom: 24),
                  itemCount: packages.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (_, i) => PackageCard(
                    package: packages[i],
                    // TODO: Payment screen kholni hai
                    onBuy: () {
                      // Navigator.pushNamed(context, AppRoutes.wallet);
                      Navigator.pushNamed(context, AppRoutes.payment,arguments: packages[i]);
                    },
                  ),
                ),
              ),
              // (Better content banner agle step mein yahan aayega)
            ],
          ),
        ),
      ),
    );
  }
}