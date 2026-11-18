import 'package:follower_for_tik_likes_views/core/models/wallet_transaction_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Knows WHERE wallet data is stored.
/// Uses SharedPreferences to persist the wallet balance across app restarts.
class WalletRepository {
  static const _balanceKey = 'wallet_balance';
  static const double initialBalance = 24.50;

  // In-memory transactions list (dummy database)
  final List<WalletTransactionModel> _transactions =
      List.of(WalletTransactionModel.dummy);

  Future<double> getBalance() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_balanceKey) ?? initialBalance;
  }

  Future<void> saveBalance(double balance) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_balanceKey, balance);
  }

  Future<List<WalletTransactionModel>> getTransactions() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return List.of(_transactions);
  }

  Future<void> addTransaction(WalletTransactionModel transaction) async {
    _transactions.insert(0, transaction);
  }
}
