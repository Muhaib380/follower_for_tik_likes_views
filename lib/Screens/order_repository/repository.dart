import 'package:follower_for_tik_likes_views/core/models/order_model.dart';
import 'package:follower_for_tik_likes_views/models/pakages_model.dart';

/// Knows WHERE order data comes from and where it is saved.
///
/// Right now it keeps everything in memory (fake database). Later, only the
/// code inside these methods changes (Firebase or a Node.js API).
/// The provider and the screens do not need to change.
class OrderRepository {
  // Fake "database". It is lost when the app is closed.
  final List<OrderModel> _orders = List.of(OrderModel.dummy);

  Future<List<OrderModel>> getOrders() async {
    // Simulates a network delay.
    await Future.delayed(const Duration(milliseconds: 400));
    return List.of(_orders);
  }

  Future<OrderModel> createOrder(PackageModel package) async {
    await Future.delayed(const Duration(milliseconds: 600));

    final order = OrderModel(
      id: 'o${DateTime.now().millisecondsSinceEpoch}',
      package: package,
      status: OrderStatus.processing, // every new order starts as Processing
      date: DateTime.now(),
    );
    _orders.insert(0, order); // newest first
    return order;
  }
}