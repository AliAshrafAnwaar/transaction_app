import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:transaction_app/data/model/client.dart';
import 'package:transaction_app/data/model/transaction.dart';
import 'package:transaction_app/data/repo/client_repo.dart';

part 'client_provider.g.dart';

@riverpod
class ClientProvider extends _$ClientProvider {
  ClientRepo repo = ClientRepo();
  @override
  Set<Client> build() {
    return clients.toSet();
  }

  void addClient(Client client) {
    repo.addClient(client);
    ref.invalidateSelf();
  }

  // Delete Client From Client list
  void deleteClient(Client client) {
    repo.deleteClient(client);
    ref.invalidateSelf();
  }

  // Delete transaction from transaction list of User
  void deleteTransaction(Client client, Transaction transaction) {
    repo.deleteTransaction(client, transaction);
    ref.invalidateSelf();
  }

  // Edite Client info
  void editClient(Client newClient, Client oldClient) {
    repo.editClient(newClient, oldClient);
    ref.invalidateSelf();
  }

  void editTransaction(
      Client client, Transaction newTransaction, Transaction oldTransaction) {
    repo.editTransaction(client, newTransaction, oldTransaction);
    ref.invalidateSelf();
  }
}
