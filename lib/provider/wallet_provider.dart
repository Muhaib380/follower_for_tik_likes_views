import 'package:flutter/foundation.dart';
import 'package:follower_for_tik_likes_views/Screens/repository/wallet_repository.dart';
import 'package:follower_for_tik_likes_views/core/models/wallet_transaction_model.dart';

/// Holds the wallet state for the entire app.
/// Screens listen to it and rebuild automatically when balance or transactions change.
class WalletProvider extends ChangeNotifier {
  final WalletRepository _repo;

  WalletProvider(this._repo) {
    load();
  }

  double _balance = WalletRepository.initialBalance;
  List<WalletTransactionModel> _transactions = [];
  bool _isLoading = false;

  double get balance => _balance;
  String get formattedBalance => '\$${_balance.toStringAsFixed(2)}';
  List<WalletTransactionModel> get transactions =>
      List.unmodifiable(_transactions);
  bool get isLoading => _isLoading;

  Future<void> load() async {
    _isLoading = true;
    notifyListeners();

    _balance = await _repo.getBalance();
    _transactions = await _repo.getTransactions();

    _isLoading = false;
    notifyListeners();
  }

  /// Adds funds to the wallet and persists to storage.
  Future<void> addMoney(double amount) async {
    if (amount <= 0) return;
    _balance += amount;
    await _repo.saveBalance(_balance);

    final transaction = WalletTransactionModel(
      id: 'tx_${DateTime.now().millisecondsSinceEpoch}',
      title: 'Top-up / Deposit',
      amount: amount,
      date: DateTime.now(),
      type: TransactionType.deposit,
    );
    await _repo.addTransaction(transaction);
    _transactions.insert(0, transaction);

    notifyListeners();
  }

  /// Deducts funds from the wallet (e.g. for a package purchase).
  Future<bool> deductMoney(double amount, {required String description}) async {
    if (_balance < amount) return false;

    _balance -= amount;
    await _repo.saveBalance(_balance);

    final transaction = WalletTransactionModel(
      id: 'tx_${DateTime.now().millisecondsSinceEpoch}',
      title: description,
      amount: amount,
      date: DateTime.now(),
      type: TransactionType.purchase,
    );
    await _repo.addTransaction(transaction);
    _transactions.insert(0, transaction);

    notifyListeners();
    return true;
  }
}
