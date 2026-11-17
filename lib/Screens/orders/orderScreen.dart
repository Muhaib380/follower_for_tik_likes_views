import 'package:flutter/material.dart';
import 'package:follower_for_tik_likes_views/Screens/orders/order_filter_tab.dart';
import 'package:follower_for_tik_likes_views/core/models/order_model.dart';
import 'package:follower_for_tik_likes_views/provider/order_Provider.dart';
import 'package:follower_for_tik_likes_views/shared/widgets/order_card.dart';
import 'package:provider/provider.dart';

/// "Orders" tab of the bottom navigation.
/// onBack: what to do when the back arrow is tapped (MainScreen shows Home).
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
    // watch: this screen rebuilds whenever OrderProvider calls notifyListeners()
    final provider = context.watch<OrderProvider>();
    final orders = provider.ordersByStatus(
      _filter == 0 ? null : OrderStatus.values[_filter - 1],
    );

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

              // ---------- List ----------
              Expanded(child: _buildBody(provider, orders)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(OrderProvider provider, List<OrderModel> orders) {
    // 1) Loading
    if (provider.isLoading && provider.orders.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    // 2) Error
    if (provider.error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(provider.error!, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            TextButton(
              // read: we only call a function here, we do not listen for changes
              onPressed: () => context.read<OrderProvider>().load(),
              child: const Text('Try again'),
            ),
          ],
        ),
      );
    }

    // 3) Empty
    if (orders.isEmpty) {
      return Center(
        child: Text(
          'No ${OrderFilterTabs.labels[_filter].toLowerCase()} orders yet',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }

    // 4) List (pull down to refresh)
    return RefreshIndicator(
      onRefresh: () => context.read<OrderProvider>().load(),
      child: ListView.separated(
        padding: const EdgeInsets.only(bottom: 16),
        itemCount: orders.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, i) => OrderCard(order: orders[i]),
      ),
    );
  }
}