import 'package:flutter/foundation.dart';
import 'package:follower_for_tik_likes_views/core/models/order_model.dart';
import 'package:follower_for_tik_likes_views/models/pakages_model.dart';
import 'package:follower_for_tik_likes_views/Screens/repository/order_repository.dart';

/// Holds the orders list for the whole app.
/// Screens listen to it and rebuild automatically when it changes.
class OrderProvider extends ChangeNotifier {
  final OrderRepository _repo;

  OrderProvider(this._repo) {
    load(); // fetch the orders as soon as the provider is created
  }

  List<OrderModel> _orders = [];
  bool _isLoading = false;
  String? _error;

  List<OrderModel> get orders => List.unmodifiable(_orders);
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Orders with the given status, or all orders when status is null.
  List<OrderModel> ordersByStatus(OrderStatus? status) =>
      status == null ? orders : _orders.where((o) => o.status == status).toList();

  Future<void> load() async {
    _isLoading = true;
    _error = null;
    notifyListeners(); // tell the screens: loading started

    try {
      _orders = await _repo.getOrders();
    } catch (e) {
      _error = 'Could not load your orders. Please try again.';
    } finally {
      _isLoading = false;
      notifyListeners(); // tell the screens: data (or error) is ready
    }
  }

  /// Called by the Payment screen. Creates the order and adds it to the list.
  Future<OrderModel> placeOrder(PackageModel package, {String target = ''}) async {
    final order = await _repo.createOrder(package, target: target);
    _orders.insert(0, order);
    notifyListeners(); // the Orders screen updates by itself
    return order;
  }
}