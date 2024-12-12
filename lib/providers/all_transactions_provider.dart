import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:transaction_app/data/model/transaction.dart';
import 'package:transaction_app/data/repo/firestore_repo.dart';

part 'all_transactions_provider.g.dart';

@riverpod
class AllTransactionsProvider extends _$AllTransactionsProvider {
  final FirestoreRepo _firestoreRepoIns = FirestoreRepo();
  bool _singleUse = true;

  @override
  Set<TransactionModel> build() {
    if (_singleUse) {
      loadTransactions();
      _singleUse = true;
    }
    ref.keepAlive();
    return {};
  }

  void loadTransactions() async {
    _firestoreRepoIns.loadTransactions().then((trans) {
      state = trans;
    });
  }
}
