import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:transaction_app/data/model/client.dart';
import 'package:transaction_app/data/model/transaction.dart';
import 'package:transaction_app/data/repo/client_repo.dart';
import 'package:transaction_app/data/repo/firestore_repo.dart';

part 'client_provider.g.dart';

@riverpod
class ClientProvider extends _$ClientProvider {
  final ClientRepo _repo = ClientRepo();
  final FirestoreRepo _firestoreRepoIns = FirestoreRepo();
  bool _singleUse = true;

  @override
  Set<Client> build() {
    //one time gaining the data
    if (_singleUse) {
      loadData();
      _singleUse = true;
    }
    ref.keepAlive();
    return {};
  }

  void loadData() {
    _firestoreRepoIns.loadData().then((onValue) {
      state = onValue;
    });
  }

  Future<void> addClient(Client client) async {
    // _repo.addClient(client);
    await _firestoreRepoIns.addClient(client);
    ref.invalidateSelf();
  }

  // Delete Client From Client list
  void deleteClient(Client client) async {
    _firestoreRepoIns.deleteClient(client.phoneNumber!).then((e) {
      state.remove(client);
    });
  }

  // Delete transaction from transaction list of User
  Future<void> deleteTransaction(
      Client client, TransactionModel transaction) async {
    _firestoreRepoIns
        .deleteClientTransaction(client.phoneNumber!, transaction.id!)
        .then((e) {
      client.transactions!.remove(transaction);
      state = {...state, client};
    });
  }

  // Edite Client info
  void editClient(Client newClient, Client oldClient) {
    _repo.editClient(newClient, oldClient);
    ref.invalidateSelf();
  }

  void editTransaction(Client client, TransactionModel newTransaction,
      TransactionModel oldTransaction) {
    _repo.editTransaction(client, newTransaction, oldTransaction);
    ref.invalidateSelf();
  }
}
