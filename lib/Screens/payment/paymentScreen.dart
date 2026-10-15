import 'package:flutter/material.dart';
import 'package:follower_for_tik_likes_views/Screens/payment/payment_method_tile.dart';
import 'package:follower_for_tik_likes_views/Screens/payment/payment_summray_card.dart';
import 'package:follower_for_tik_likes_views/core/router/app_routes.dart';
import 'package:follower_for_tik_likes_views/models/pakages_model.dart';
import 'package:follower_for_tik_likes_views/shared/widgets/custom_button.dart';

/// Packages screen se Buy dabane par khulti hai. Chuna hua package yahan aata hai.
class PaymentScreen extends StatefulWidget {
  final PackageModel package;

  const PaymentScreen({super.key, required this.package});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  // Apni images in naamon se assets/images/ mein rakhein (ya path badal dein)
  static const _methods = [
    PaymentMethodItem(
      id: 'google_pay',
      name: 'Google Pay',
      imagePath: 'assets/icons/google_pay.png',
      fallbackIcon: Icons.account_balance_wallet_rounded,
    ),
    PaymentMethodItem(
      id: 'card',
      name: 'Credit / Debit Card',
      imagePath: 'assets/icons/credit_card.png',
      fallbackIcon: Icons.credit_card_rounded,
    ),
    PaymentMethodItem(
      id: 'paypal',
      name: 'PayPal',
      imagePath: 'assets/icons/paypal.png',
      fallbackIcon: Icons.payments_rounded,
    ),
    PaymentMethodItem(
      id: 'apple_pay',
      name: 'Apple Pay',
      imagePath: 'assets/icons/Apple_icon.png',
      fallbackIcon: Icons.apple,
    ),
  ];

  int _selected = 0; // pehle se Google Pay chuna hua

  void _proceed() {
    debugPrint('1. Proceed dabaya');
    debugPrint('2. package = ${widget.package.title}');
    Navigator.pushReplacementNamed(
      context,
      AppRoutes.orderSuccess,
      arguments: widget.package,
    );
    debugPrint('3. navigation ho gayi');
  }

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
                  Text('Payment',
                      style: Theme.of(context).textTheme.headlineMedium),
                ],
              ),
              const SizedBox(height: 18),

              // ---------- Chuna hua package ----------
              PaymentSummaryCard(package: widget.package),
              const SizedBox(height: 26),

              // ---------- Payment methods ----------
              Text('Choose Payment Method',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 14),

              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: _methods.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (_, i) => PaymentMethodTile(
                    method: _methods[i],
                    selected: i == _selected,
                    onTap: () => setState(() => _selected = i),
                  ),
                ),
              ),

              // ---------- Proceed to Pay ----------
              const SizedBox(height: 12),
              CustomButton(text: 'Proceed to Pay', onPressed: _proceed),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}