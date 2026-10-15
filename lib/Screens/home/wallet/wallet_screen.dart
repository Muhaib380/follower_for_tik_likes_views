import 'package:flutter/material.dart';
import 'package:follower_for_tik_likes_views/Screens/home/wallet/wallet_balance_card.dart';
import 'package:follower_for_tik_likes_views/Screens/home/wallet/widget/reward_banner.dart';
import 'package:follower_for_tik_likes_views/Screens/home/wallet/widget/wallet_option_tile.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  Text('Wallet',
                      style: Theme.of(context).textTheme.headlineMedium),
                ],
              ),
              const SizedBox(height: 18),

              // ---------- Balance card ----------
              // Abhi dummy balance. Baad mein WalletProvider se aayega.
              WalletBalanceCard(
                balance: '\$24.50',
                // TODO: Withdraw ka kaam baad mein
                onWithdraw: () {},
              ),
              const SizedBox(height: 20),

              // ---------- Neeche ka hissa (scroll ho sakta hai) ----------
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    children: [
                      WalletOptionTile(
                        icon: Icons.add_card_rounded,
                        title: 'Add Money',
                        // TODO: Add Money ka kaam baad mein
                        onTap: () {},
                      ),
                      const SizedBox(height: 10),
                      WalletOptionTile(
                        icon: Icons.receipt_long_rounded,
                        title: 'Transaction History',
                        // TODO: Transaction History screen baad mein
                        onTap: () {},
                      ),
                      const SizedBox(height: 28),
                      const RewardsBanner(),
                    ],
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