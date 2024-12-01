import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:transaction_app/data/model/client.dart';
import 'package:transaction_app/data/model/transaction.dart';
import 'package:transaction_app/data/repo/client_repo.dart';
import 'package:transaction_app/data/repo/excel_repo.dart';

part 'client_provider.g.dart';

@riverpod
class ClientProvider extends _$ClientProvider {
  final ClientRepo _repo = ClientRepo();
  @override
  Set<Client> build() {
    return clients.toSet();
  }

  void addClient(Client client) {
    _repo.addClient(client);
    ref.invalidateSelf();
  }

  // Delete Client From Client list
  void deleteClient(Client client) {
    _repo.deleteClient(client);
    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      ref.invalidateSelf();
    });
  }

  // Delete transaction from transaction list of User
  void deleteTransaction(Client client, Transaction transaction) {
    _repo.deleteTransaction(client, transaction);
    ref.invalidateSelf();
  }

  // Edite Client info
  void editClient(Client newClient, Client oldClient) {
    _repo.editClient(newClient, oldClient);
    ref.invalidateSelf();
  }

  void editTransaction(
      Client client, Transaction newTransaction, Transaction oldTransaction) {
    _repo.editTransaction(client, newTransaction, oldTransaction);
    ref.invalidateSelf();
  }

  void exportClientsToExcel() {
    ExcelRepo excelRepo = ExcelRepo();
    excelRepo.exportClientsToExcel(state);
    ref.invalidateSelf();
  }
}
