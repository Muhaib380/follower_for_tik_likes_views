import 'package:flutter/material.dart';
import 'package:follower_for_tik_likes_views/Screens/payment/payment_method_tile.dart';
import 'package:follower_for_tik_likes_views/Screens/payment/payment_summray_card.dart';
import 'package:follower_for_tik_likes_views/core/constants/app_colors.dart';
import 'package:follower_for_tik_likes_views/core/router/app_routes.dart';
import 'package:follower_for_tik_likes_views/models/pakages_model.dart';
import 'package:follower_for_tik_likes_views/provider/order_Provider.dart';
import 'package:follower_for_tik_likes_views/provider/user_provider.dart';
import 'package:follower_for_tik_likes_views/provider/wallet_provider.dart';
import 'package:follower_for_tik_likes_views/shared/widgets/custom_button.dart';
import 'package:follower_for_tik_likes_views/shared/widgets/order_target_feild.dart';
import 'package:provider/provider.dart';

/// Opens when Buy is tapped on the Packages screen. Receives the chosen package.
class PaymentScreen extends StatefulWidget {
  final PackageModel package;

  const PaymentScreen({super.key, required this.package});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _targetCtrl;

  int _selected = 0; // TrendSpark Wallet is selected by default
  bool _paying = false; // stops double taps while the order is being created

  @override
  void initState() {
    super.initState();
    // Followers: pre-fill the username the user already saved on the Profile screen.
    final saved = context.read<UserProvider>().tiktokUsername;
    final isFollowers = widget.package.type == PackageType.followers;
    _targetCtrl = TextEditingController(text: isFollowers ? (saved ?? '') : '');
  }

  @override
  void dispose() {
    _targetCtrl.dispose();
    super.dispose();
  }

  List<PaymentMethodItem> _getMethods(WalletProvider wallet) {
    return [
      PaymentMethodItem(
        id: 'wallet',
        name: 'TrendSpark Wallet',
        imagePath: 'assets/icons/wallet.png',
        fallbackIcon: Icons.account_balance_wallet_rounded,
        subtitle: 'Available: ${wallet.formattedBalance}',
      ),
      const PaymentMethodItem(
        id: 'easypaisa',
        name: 'Easypaisa',
        imagePath: 'assets/icons/easypaisa.png',
        fallbackIcon: Icons.account_balance_rounded,
        subtitle: 'Direct mobile account',
      ),
      const PaymentMethodItem(
        id: 'jazzcash',
        name: 'JazzCash',
        imagePath: 'assets/icons/jazzcash.png',
        fallbackIcon: Icons.phone_android_rounded,
        subtitle: 'Direct mobile account',
      ),
      const PaymentMethodItem(
        id: 'google_pay',
        name: 'Google Pay',
        imagePath: 'assets/icons/google_pay.png',
        fallbackIcon: Icons.account_balance_wallet_rounded,
      ),
      const PaymentMethodItem(
        id: 'card',
        name: 'Credit / Debit Card',
        imagePath: 'assets/icons/credit_card.png',
        fallbackIcon: Icons.credit_card_rounded,
      ),
      const PaymentMethodItem(
        id: 'paypal',
        name: 'PayPal',
        imagePath: 'assets/icons/paypal.png',
        fallbackIcon: Icons.payments_rounded,
      ),
      const PaymentMethodItem(
        id: 'apple_pay',
        name: 'Apple Pay',
        imagePath: 'assets/icons/Apple_icon.png',
        fallbackIcon: Icons.apple,
      ),
    ];
  }

  Future<void> _proceed(List<PaymentMethodItem> methods) async {
    if (_paying) return;

    // Stop here if the username / link is missing or invalid.
    if (!_formKey.currentState!.validate()) return;

    final type = widget.package.type;
    final target = OrderTargetField.normalize(type, _targetCtrl.text);
    final chosenMethod = methods[_selected];

    // If paying with TrendSpark Wallet, verify sufficient balance
    if (chosenMethod.id == 'wallet') {
      final wallet = context.read<WalletProvider>();
      final price = widget.package.price;

      if (wallet.balance < price) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
            content: Text(
              'Insufficient wallet balance (${wallet.formattedBalance})! Package price is \$${price.toStringAsFixed(2)}.',
            ),
            duration: const Duration(seconds: 4),
            action: SnackBarAction(
              label: 'Add Money',
              textColor: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.wallet);
              },
            ),
          ),
        );
        return;
      }

      setState(() => _paying = true);

      // Deduct balance and record transaction
      final success = await wallet.deductMoney(
        price,
        description: 'Purchase: ${widget.package.title}',
      );

      if (!success) {
        setState(() => _paying = false);
        return;
      }
    } else {
      setState(() => _paying = true);
    }

    // If the user never linked a TikTok username, remember the one they just typed.
    final user = context.read<UserProvider>();
    if (type == PackageType.followers && !user.hasTiktokUsername) {
      await user.setTiktokUsername(target);
    }

    if (!mounted) return;
    await context
        .read<OrderProvider>()
        .placeOrder(widget.package, target: target);

    if (!mounted) return;
    Navigator.pushReplacementNamed(
      context,
      AppRoutes.orderSuccess,
      arguments: widget.package,
    );
  }

  @override
  Widget build(BuildContext context) {
    final wallet = context.watch<WalletProvider>();
    final methods = _getMethods(wallet);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Everything scrolls, so the keyboard never causes an overflow.
            Expanded(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ---------- Header ----------
                      Row(
                        children: [
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            borderRadius: BorderRadius.circular(20),
                            child: const Padding(
                              padding: EdgeInsets.all(8),
                              child: Icon(Icons.arrow_back_ios_new_rounded,
                                  size: 20),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text('Payment',
                              style:
                                  Theme.of(context).textTheme.headlineMedium),
                        ],
                      ),
                      const SizedBox(height: 18),

                      // ---------- Chosen package ----------
                      PaymentSummaryCard(package: widget.package),
                      const SizedBox(height: 24),

                      // ---------- Username / video link ----------
                      OrderTargetField(
                        type: widget.package.type,
                        controller: _targetCtrl,
                      ),
                      const SizedBox(height: 26),

                      // ---------- Payment methods ----------
                      Text('Choose Payment Method',
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 14),
                      for (int i = 0; i < methods.length; i++) ...[
                        PaymentMethodTile(
                          method: methods[i],
                          selected: i == _selected,
                          onTap: () => setState(() => _selected = i),
                        ),
                        if (i != methods.length - 1)
                          const SizedBox(height: 10),
                      ],
                    ],
                  ),
                ),
              ),
            ),

            // ---------- Proceed to Pay (always visible at the bottom) ----------
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
              child: CustomButton(
                text: 'Proceed to Pay',
                isLoading: _paying,
                onPressed: () => _proceed(methods),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
