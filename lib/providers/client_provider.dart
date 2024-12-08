import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:transaction_app/data/model/client.dart';
import 'package:transaction_app/data/model/transaction.dart';
import 'package:transaction_app/data/repo/client_repo.dart';
import 'package:transaction_app/data/services/firestore_services.dart';

part 'client_provider.g.dart';

@riverpod
class ClientProvider extends _$ClientProvider {
  final ClientRepo _repo = ClientRepo();
  final FirestoreServices _ins = FirestoreServices();
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
    _ins.loadData().then((onValue) {
      state = onValue;
    });
  }

  void addClient(Client client) {
    _repo.addClient(client);
    ref.invalidateSelf();
  }

  // Delete Client From Client list
  void deleteClient(Client client) async {
    state.remove(client);
    await _ins.deleteClient(clientId: client.phoneNumber!);
    loadData();
  }

  // Delete transaction from transaction list of User
  void deleteTransaction(Client client, TransactionModel transaction) {
    client.transactions!.remove(transaction);
    state = {...state, client};
    _ins.deleteClientTransaction(
        clientId: client.phoneNumber!, transactionId: transaction.id!);
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
