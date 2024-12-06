import 'package:transaction_app/data/model/client.dart';
import 'package:transaction_app/data/model/transaction.dart';

class ClientRepo {
  // Add to Alltransactions and to Client
  void addClient(Client client) {
    client.addClient(client);
  }

  // Delete Client From Client list
  void deleteClient(Client client) {
    client.deleteClient(client);
  }

  // Delete transaction from transaction list of User
  void deleteTransaction(Client client, TransactionModel transaction) {
    client.deleteTransaction(client, transaction);
  }

  // Edite Client info
  void editClient(Client newClient, Client oldClient) {
    oldClient.editClient(newClient, oldClient);
  }

  void editTransaction(Client client, TransactionModel newTransaction,
      TransactionModel oldTransaction) {
    client.editClientTransaction(client, newTransaction, oldTransaction);
  }
}
