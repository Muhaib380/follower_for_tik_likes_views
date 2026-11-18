import 'package:follower_for_tik_likes_views/models/pakages_model.dart';

/// Tab order ke saath match karta hai: 0 All, 1 Processing, 2 Completed, 3 Canceled
enum OrderStatus { processing, completed, canceled }

class OrderModel {
  final String id;
  final PackageModel package;
  final OrderStatus status;
  final DateTime date;
  final String target; // TikTok username (followers) or video link (likes / views)

  const OrderModel({
    required this.id,
    required this.package,
    required this.status,
    required this.date,
    this.target = '', // optional, so the old dummy orders still work
  });
// ... rest of the class stays the same


  /// What the Orders list shows under the package name:
  /// "@username" for followers, the video link for likes / views.
  String get targetLabel {
    if (target.isEmpty) return 'Real & Active'; // old orders without a target
    return package.type == PackageType.followers ? '@$target' : target;
  }

  String get statusLabel => switch (status) {
    OrderStatus.processing => 'Processing',
    OrderStatus.completed => 'Completed',
    OrderStatus.canceled => 'Canceled',
  };

  /// "Oct 12, 2026 - 10:24 AM"
  String get dateLabel {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    final h12 = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final min = date.minute.toString().padLeft(2, '0');
    final ampm = date.hour >= 12 ? 'PM' : 'AM';
    return '${months[date.month - 1]} ${date.day}, ${date.year} - '
        '${h12.toString().padLeft(2, '0')}:$min $ampm';
  }

  // ---------------- Dummy data (baad mein OrderProvider / API se aayega) ----------------
  static final List<OrderModel> dummy = [
    OrderModel(
      id: 'o1',
      package: const PackageModel(
          id: 'f3', type: PackageType.followers, quantity: 1000, price: 16.99),
      status: OrderStatus.processing,
      date: DateTime(2026, 10, 12, 10, 24),
      target: 'muhibkhan',
    ),
    OrderModel(
      id: 'o2',
      package: const PackageModel(
          id: 'l2', type: PackageType.likes, quantity: 500, price: 2.99),
      status: OrderStatus.completed,
      date: DateTime(2026, 10, 10, 20, 15),
      target: 'https://www.tiktok.com/@muhibkhan/video/7300000000000000001',
    ),
    OrderModel(
      id: 'o3',
      package: const PackageModel(
          id: 'v2', type: PackageType.views, quantity: 1000, price: 3.99),
      status: OrderStatus.completed,
      date: DateTime(2026, 10, 8, 13, 42),
      target: 'https://www.tiktok.com/@muhibkhan/video/7300000000000000002',
    ),
    OrderModel(
      id: 'o4',
      package: const PackageModel(
          id: 'f4', type: PackageType.followers, quantity: 5000, price: 68.99),
      status: OrderStatus.canceled,
      date: DateTime(2026, 10, 5, 11, 20),
      target: 'muhibkhan',
    ),
  ];
}