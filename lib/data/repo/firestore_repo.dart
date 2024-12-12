import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:transaction_app/data/model/client.dart';
import 'package:transaction_app/data/model/transaction.dart';
import 'package:transaction_app/data/services/firestore_services.dart';

class FirestoreRepo {
  //Instance for calling FireStoreServices
  FirestoreServices firestoreIns = FirestoreServices();

  //GET Data Only Once
  Future<Set<Client>> loadClients() async {
    return await firestoreIns.loadClients();
  }

  //Transactoins
  Future<Set<TransactionModel>> loadTransactions() async {
    return await firestoreIns.loadTransactions();
  }

  //ADD
  Future<void> addClient(Client client) async {
    await firestoreIns.addClient(client);
  }

  //EDIT
  //client
  Future<void> editClient(String clientid, Client updatedClient) async {
    await firestoreIns.editClient(
        clientId: clientid, updatedClient: updatedClient);
  }

//client
  Future<void> editClientTransaction(String clientid, String transactionId,
      TransactionModel updatedTransaction) async {
    await firestoreIns.editClientTransaction(
        clientId: clientid,
        transactionId: transactionId,
        updatedTransaction: updatedTransaction);
  }

  //DELETE
  //client
  Future<void> deleteClient(String clientId) async {
    await firestoreIns.deleteClient(clientId: clientId);
  }

  //Transaction of client
  Future<void> deleteClientTransaction(
      String clientId, String transactionId) async {
    await firestoreIns.deleteClientTransaction(
        clientId: clientId, transactionId: transactionId);
  }
}
