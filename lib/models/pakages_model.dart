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

  /// 50 -> "50", 1000 -> "1K", 2500 -> "2.5K", 1000000 -> "1M"
  String get quantityLabel {
    if (quantity >= 1000000) {
      final m = quantity / 1000000;
      return m == m.toInt() ? '${m.toInt()}M' : '${m.toStringAsFixed(1)}M';
    }
    if (quantity >= 1000) {
      final k = quantity / 1000;
      return k == k.toInt() ? '${k.toInt()}K' : '${k.toStringAsFixed(1)}K';
    }
    return '$quantity';
  }

  String get typeName => switch (type) {
    PackageType.followers => 'Followers',
    PackageType.likes => 'Likes',
    PackageType.views => 'Views',
  };

  String get title => '$quantityLabel $typeName'; // e.g. "1K Followers"
  String get priceLabel => '\$${price.toStringAsFixed(2)}'; // e.g. "$16.99"

  // ---------------- Dummy data (baad mein API / Provider se aayega) ----------------
  static const List<PackageModel> dummy = [
    // ---------- Followers Packages ----------
    PackageModel(id: 'f0', type: PackageType.followers, quantity: 50, price: 1.49),
    PackageModel(id: 'f1', type: PackageType.followers, quantity: 100, price: 2.99),
    PackageModel(id: 'f2', type: PackageType.followers, quantity: 250, price: 5.49),
    PackageModel(id: 'f3_500', type: PackageType.followers, quantity: 500, price: 8.99),
    PackageModel(id: 'f3', type: PackageType.followers, quantity: 1000, price: 16.99),
    PackageModel(id: 'f3_2500', type: PackageType.followers, quantity: 2500, price: 36.99),
    PackageModel(id: 'f4', type: PackageType.followers, quantity: 5000, price: 68.99),
    PackageModel(id: 'f5', type: PackageType.followers, quantity: 10000, price: 129.99),
    PackageModel(id: 'f6', type: PackageType.followers, quantity: 25000, price: 299.99),
    PackageModel(id: 'f7', type: PackageType.followers, quantity: 50000, price: 549.99),
    PackageModel(id: 'f8', type: PackageType.followers, quantity: 100000, price: 999.99),

    // ---------- Likes Packages ----------
    PackageModel(id: 'l0', type: PackageType.likes, quantity: 50, price: 0.99),
    PackageModel(id: 'l1', type: PackageType.likes, quantity: 100, price: 1.99),
    PackageModel(id: 'l1_250', type: PackageType.likes, quantity: 250, price: 2.49),
    PackageModel(id: 'l2', type: PackageType.likes, quantity: 500, price: 2.99),
    PackageModel(id: 'l3', type: PackageType.likes, quantity: 1000, price: 5.99),
    PackageModel(id: 'l3_2500', type: PackageType.likes, quantity: 2500, price: 13.99),
    PackageModel(id: 'l4', type: PackageType.likes, quantity: 5000, price: 24.99),
    PackageModel(id: 'l5', type: PackageType.likes, quantity: 10000, price: 44.99),
    PackageModel(id: 'l6', type: PackageType.likes, quantity: 25000, price: 99.99),
    PackageModel(id: 'l7', type: PackageType.likes, quantity: 50000, price: 189.99),

    // ---------- Views Packages ----------
    PackageModel(id: 'v0', type: PackageType.views, quantity: 250, price: 0.99),
    PackageModel(id: 'v1', type: PackageType.views, quantity: 500, price: 1.99),
    PackageModel(id: 'v2', type: PackageType.views, quantity: 1000, price: 3.99),
    PackageModel(id: 'v2_2500', type: PackageType.views, quantity: 2500, price: 8.99),
    PackageModel(id: 'v3', type: PackageType.views, quantity: 5000, price: 14.99),
    PackageModel(id: 'v4', type: PackageType.views, quantity: 10000, price: 26.99),
    PackageModel(id: 'v5_25k', type: PackageType.views, quantity: 25000, price: 59.99),
    PackageModel(id: 'v5', type: PackageType.views, quantity: 50000, price: 99.99),
    PackageModel(id: 'v6', type: PackageType.views, quantity: 100000, price: 179.99),
    PackageModel(id: 'v7', type: PackageType.views, quantity: 500000, price: 699.99),
    PackageModel(id: 'v8', type: PackageType.views, quantity: 1000000, price: 1299.99),
  ];

  static List<PackageModel> byType(PackageType type) =>
      dummy.where((p) => p.type == type).toList();
}
