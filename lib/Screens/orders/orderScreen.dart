import 'package:flutter/material.dart';
import 'package:follower_for_tik_likes_views/Screens/orders/order_filter_tab.dart';

/// Bottom nav ka "Orders" tab.
/// onBack: back arrow dabane par kya karna hai (MainScreen Home tab par bhej dega).
class OrdersScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const OrdersScreen({super.key, this.onBack});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  int _filter = 0; // 0 All, 1 Processing, 2 Completed, 3 Canceled

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
                    onTap: widget.onBack,
                    borderRadius: BorderRadius.circular(20),
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text('My Orders',
                      style: Theme.of(context).textTheme.headlineMedium),
                ],
              ),
              const SizedBox(height: 18),

              // ---------- Filter tabs ----------
              OrderFilterTabs(
                selectedIndex: _filter,
                onChanged: (i) => setState(() => _filter = i),
              ),
              const SizedBox(height: 16),

              // ---------- List (agle step mein) ----------
              Expanded(
                child: Center(
                  child: Text(
                    '${OrderFilterTabs.labels[_filter]} orders ki list agle step mein',
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