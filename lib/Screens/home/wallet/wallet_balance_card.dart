import 'package:flutter/material.dart';
import 'package:follower_for_tik_likes_views/core/constants/app_colors.dart';

/// "Available Balance $24.50" wala card, peeche image sirf is card ke andar.
class WalletBalanceCard extends StatelessWidget {
  final String balance; // e.g. '$24.50'
  final VoidCallback? onWithdraw;

  /// Card ki background image. File na mile to sirf gradient dikhega.
  // final String backgroundImage;

  const WalletBalanceCard({
    super.key,
    required this.balance,
    this.onWithdraw,
    // this.backgroundImage = 'assets/images/wallet_card_bg.png',
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: Stack(
        children: [
          // 1) Gradient (image na ho ya load hone se pehle)
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF6C3CE9), Color(0xFFC04DF0)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
          ),

          // 2) Background image (sirf card ke andar)
          // Positioned.fill(
          //   child: Image.asset(
          //     // backgroundImage,
          //     fit: BoxFit.cover,
          //     errorBuilder: (_, __, ___) => const SizedBox.shrink(),
          //   ),
          // ),

          // 3) Content
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 22),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Available Balance',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.92),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        balance,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.w700,
                          height: 1.1,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: onWithdraw,
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Withdraw',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}