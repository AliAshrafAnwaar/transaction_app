import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:transaction_app/data/model/transaction.dart';
import 'package:transaction_app/data/repo/firestore_repo.dart';

part 'all_transactions_provider.g.dart';

@riverpod
class AllTransactionsProvider extends _$AllTransactionsProvider {
  final FirestoreRepo _firestoreRepoIns = FirestoreRepo();

  @override
  Set<TransactionModel> build() {
    ref.keepAlive();
    return {};
  }

  Future<void> loadTransactions() async {
    state = await _firestoreRepoIns.loadTransactions();
  }
}
