enum TransactionType { deposit, purchase, withdrawal }

class WalletTransactionModel {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final TransactionType type;

  const WalletTransactionModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.type,
  });

  /// Factory constructor to parse JSON from Node.js / MySQL backend
  factory WalletTransactionModel.fromJson(Map<String, dynamic> json) {
    return WalletTransactionModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ??
          (json['type']?.toString().toLowerCase() == 'deposit'
              ? 'Top-up / Deposit'
              : 'Package Purchase'),
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      date: json['date'] != null
          ? (DateTime.tryParse(json['date'].toString()) ?? DateTime.now())
          : (json['created_at'] != null
              ? (DateTime.tryParse(json['created_at'].toString()) ??
                  DateTime.now())
              : DateTime.now()),
      type: switch (json['type']?.toString().toLowerCase()) {
        'deposit' || 'topup' => TransactionType.deposit,
        'purchase' => TransactionType.purchase,
        'withdrawal' || 'withdraw' => TransactionType.withdrawal,
        _ => TransactionType.deposit,
      },
    );
  }

  /// Converts this WalletTransactionModel to a JSON map to send to backend or storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
      'type': type.name,
    };
  }

  bool get isCredit => type == TransactionType.deposit;

  String get amountLabel {
    final prefix = isCredit ? '+\$' : '-\$';
    return '$prefix${amount.toStringAsFixed(2)}';
  }

  String get dateLabel {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    final h12 = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final min = date.minute.toString().padLeft(2, '0');
    final ampm = date.hour >= 12 ? 'PM' : 'AM';
    return '${months[date.month - 1]} ${date.day}, ${date.year} - ${h12.toString().padLeft(2, '0')}:$min $ampm';
  }

  static final List<WalletTransactionModel> dummy = [
    WalletTransactionModel(
      id: 't1',
      title: 'Top-up / Deposit',
      amount: 25.00,
      date: DateTime.now().subtract(const Duration(days: 2)),
      type: TransactionType.deposit,
    ),
    WalletTransactionModel(
      id: 't2',
      title: '1K Followers Package',
      amount: 16.99,
      date: DateTime.now().subtract(const Duration(days: 4)),
      type: TransactionType.purchase,
    ),
    WalletTransactionModel(
      id: 't3',
      title: 'Top-up / Deposit',
      amount: 16.49,
      date: DateTime.now().subtract(const Duration(days: 7)),
      type: TransactionType.deposit,
    ),
  ];
}
