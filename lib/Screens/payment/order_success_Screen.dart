import 'package:flutter/material.dart';
import 'package:follower_for_tik_likes_views/Screens/payment/order_success_header.dart';
import 'package:follower_for_tik_likes_views/core/constants/app_colors.dart';
import 'package:follower_for_tik_likes_views/core/router/app_routes.dart';
import 'package:follower_for_tik_likes_views/models/pakages_model.dart';
import 'package:follower_for_tik_likes_views/shared/widgets/custom_button.dart';

/// Payment ke baad khulti hai. Chuna hua package yahan aata hai.
class OrderSuccessScreen extends StatelessWidget {
  final PackageModel package;

  const OrderSuccessScreen({super.key, required this.package});

  void _viewOrders(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.main,
          (_) => false,
      arguments: 1, // 1 = Orders tab
    );
  }

  void _backToHome(BuildContext context) {
    // Beech ki saari screens (Packages, Payment, ...) history se hata do,
    // taake Home se back dabane par wapas yahan na aayein.
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.main, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    // Order ho chuka hai, is liye back button se wapas Payment par nahi jana.
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF251672), Color(0xFF150C3D)],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(22, 40, 22, 28),
              child: Column(
                children: [
                  // ---------- Part 1: upar ka hissa ----------
                  const OrderSuccessHeader(),
                  const SizedBox(height: 28),

                  // ---------- Part 2: package card ----------
                  _OrderPackageCard(package: package),
                  const SizedBox(height: 24),

                  // ---------- Buttons ----------
                  CustomButton(
                    text: 'View Orders',
                    onPressed: () => _viewOrders(context),
                  ),
                  const SizedBox(height: 14),
                  _OutlinedLightButton(
                    text: 'Back to Home',
                    onPressed: () => _backToHome(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Dark background par safed card: icon, "1K Followers", "Real & Active", price.
class _OrderPackageCard extends StatelessWidget {
  final PackageModel package;
  const _OrderPackageCard({required this.package});

  IconData get _icon => switch (package.type) {
    PackageType.followers => Icons.person_rounded,
    PackageType.likes => Icons.favorite_rounded,
    PackageType.views => Icons.play_arrow_rounded,
  };

  Color get _iconColor => package.type == PackageType.likes
      ? const Color(0xFFFF4D6D)
      : AppColors.primary;

  Color get _circleColor => package.type == PackageType.likes
      ? const Color(0xFFFFE3EA)
      : const Color(0xFFE6DEFF);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.96),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.18),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 58,
            width: 58,
            decoration:
            BoxDecoration(color: _circleColor, shape: BoxShape.circle),
            child: Icon(_icon, color: _iconColor, size: 30),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  package.title,
                  style: const TextStyle(
                    color: Color(0xFF1B1636),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Real & Active',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Text(
            package.priceLabel,
            style: const TextStyle(
              color: Color(0xFF1B1636),
              fontSize: 19,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

/// Dark background ke liye outlined button (safed border aur safed text).
class _OutlinedLightButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const _OutlinedLightButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 56,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white.withOpacity(0.45), width: 1.4),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}