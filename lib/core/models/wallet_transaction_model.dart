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
