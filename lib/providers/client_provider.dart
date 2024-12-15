import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:transaction_app/data/model/client.dart';
import 'package:transaction_app/data/model/transaction.dart';
import 'package:transaction_app/data/repo/firestore_repo.dart';

part 'client_provider.g.dart';

class ClientState {
  final bool isLoading;
  final Set<Client> clients;

  const ClientState({
    this.isLoading = false,
    this.clients = const {},
  });

  ClientState copyWith({bool? isLoading, Set<Client>? clients}) {
    return ClientState(
      isLoading: isLoading ?? this.isLoading,
      clients: clients ?? this.clients,
    );
  }
}

@riverpod
class ClientProvider extends _$ClientProvider {
  final FirestoreRepo _firestoreRepoIns = FirestoreRepo();

  @override
  Set<Client> build() {
    ref.keepAlive();
    return {};
  }

  Future<bool> loadClients() async {
    state = await _firestoreRepoIns.loadClients();
    return true;
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
    _firestoreRepoIns.editClient(oldClient.phoneNumber!, newClient).then(
      (e) {
        state = state.map(
          (client) {
            if (client == oldClient) {
              client.name = newClient.name;
              client.phoneNumber = newClient.phoneNumber;
            }
            return client;
          },
        ).toSet();
      },
    );
  }

  void editTransaction(Client client, TransactionModel newTransaction,
      TransactionModel oldTransaction) async {
    await _firestoreRepoIns
        .editClientTransaction(
            client.phoneNumber!, oldTransaction.id!, newTransaction)
        .then((value) {
      state = state.map(
        (c) {
          if (c == client) {
            c.transactions!.remove(oldTransaction);
            c.transactions!.add(newTransaction);
          }
          return c;
        },
      ).toSet();
    });
  }

  final TextEditingController _getterSearchController = TextEditingController();

  void setterSearchController(TextEditingController search) {
    _getterSearchController.text = search.text;
  }

  TextEditingController getterSearchController() {
    return _getterSearchController;
  }
}
