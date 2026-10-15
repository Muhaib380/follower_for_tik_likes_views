enum PackageType { followers, likes, views }

class PackageModel {
  final String id;
  final PackageType type;
  final int quantity;
  final double price;

  const PackageModel({
    required this.id,
    required this.type,
    required this.quantity,
    required this.price,
  });

  /// 1000 -> "1K", 10000 -> "10K", 500 -> "500"
  String get quantityLabel {
    if (quantity >= 1000 && quantity % 1000 == 0) {
      return '${quantity ~/ 1000}K';
    }
    return '$quantity';
  }

  String get typeName => switch (type) {
    PackageType.followers => 'Followers',
    PackageType.likes => 'Likes',
    PackageType.views => 'Views',
  };

  String get title => '$quantityLabel $typeName'; // "100 Followers"
  String get priceLabel => '\$${price.toStringAsFixed(2)}'; // "$2.99"

  // ---------------- Dummy data (baad mein API / Provider se aayega) ----------------
  static const List<PackageModel> dummy = [
    // Followers
    PackageModel(id: 'f1', type: PackageType.followers, quantity: 100, price: 2.99),
    PackageModel(id: 'f2', type: PackageType.followers, quantity: 500, price: 8.99),
    PackageModel(id: 'f3', type: PackageType.followers, quantity: 1000, price: 16.99),
    PackageModel(id: 'f4', type: PackageType.followers, quantity: 5000, price: 68.99),
    PackageModel(id: 'f5', type: PackageType.followers, quantity: 10000, price: 129.99),
    // Likes
    PackageModel(id: 'l1', type: PackageType.likes, quantity: 100, price: 1.99),
    PackageModel(id: 'l2', type: PackageType.likes, quantity: 500, price: 2.99),
    PackageModel(id: 'l3', type: PackageType.likes, quantity: 1000, price: 5.99),
    PackageModel(id: 'l4', type: PackageType.likes, quantity: 5000, price: 24.99),
    PackageModel(id: 'l5', type: PackageType.likes, quantity: 10000, price: 44.99),
    // Views
    PackageModel(id: 'v1', type: PackageType.views, quantity: 500, price: 1.99),
    PackageModel(id: 'v2', type: PackageType.views, quantity: 1000, price: 3.99),
    PackageModel(id: 'v3', type: PackageType.views, quantity: 5000, price: 14.99),
    PackageModel(id: 'v4', type: PackageType.views, quantity: 10000, price: 26.99),
    PackageModel(id: 'v5', type: PackageType.views, quantity: 50000, price: 99.99),
  ];

  static List<PackageModel> byType(PackageType type) =>
      dummy.where((p) => p.type == type).toList();
}