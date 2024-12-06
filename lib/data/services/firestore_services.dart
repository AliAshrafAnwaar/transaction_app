import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:transaction_app/data/model/client.dart';
import 'package:transaction_app/data/model/transaction.dart';

class FirestoreServices {
  final transactions = FirebaseFirestore.instance.collection('Transactions');
  final clients = FirebaseFirestore.instance.collection('Clients');

  // For adding Transaction and creating client if don't exist
  Future<void> addClient({required Client client}) async {
    String clientId = client.phoneNumber!;
    TransactionModel transaction =
        client.transactions!.first; // Simplified access
    final clientDoc = clients.doc(clientId);
    final snapshot = await clientDoc.get();

    if (!snapshot.exists) {
      // Add new client with full data
      await clientDoc.set(client.toFirestore());
      print("New client added: $clientId");
    } else {
      // Update existing client transactions
      if (client.transactions != null) {
        await clientDoc.update({
          'transactions': FieldValue.arrayUnion([transaction.toFirestore()]),
        });
      }
      print("Client updated with transactions: $clientId");
    }

    // Add transaction to 'Transactions' collection
    if (transaction.id != null) {
      await transactions
          .doc(transaction.id!.toString())
          .set(transaction.toFirestore());
      print("Transaction added: ${transaction.id}");
    } else {
      throw Exception("Transaction ID is null. Cannot save transaction.");
    }
  }

  // Edit client data
  Future<void> editClient(
      {required String clientId, required Client updatedClient}) async {
    final clientDoc = clients.doc(clientId);

    // Check if client exists
    final snapshot = await clientDoc.get();
    if (snapshot.exists) {
      // Update client data
      await clientDoc.set({
        'name': updatedClient.name,
        'phone number': updatedClient.phoneNumber,
      });
      print("Client data updated for ID: $clientId");
    } else {
      throw Exception("Client with ID $clientId does not exist.");
    }
  }

  //  edit transaction inside client unfinished yet
  Future<void> editClientTransaction(
      {required String clientId,
      required transactionId,
      required TransactionModel updatedTransaction}) async {
    final clientDoc = clients.doc(clientId);

    // Check if client exists
    final snapshot = await clientDoc.get();
    if (snapshot.exists) {
      Client client = Client().fromFirestore(snapshot.data()!);
      final transactions = client.transactions ?? [];

      for (var transaction in transactions) {
        if (transaction.id == transactionId) {
        } else {}
      }
    }
  }

  // Delete Client
  Future<void> deleteClient({
    required String clientId,
  }) async {
    final clientDoc = clients.doc(clientId);

    // Check if client exists
    final snapshot = await clientDoc.get();
    if (snapshot.exists) {
      await clientDoc.delete();
    }
  }

// Delete transaction
  Future<void> deleteClientTransaction({
    required String clientId,
    required String transactionId,
  }) async {
    final clientDoc = clients.doc(clientId);

    // Check if client exists
    final snapshot = await clientDoc.get();
    if (snapshot.exists) {
      Client client = Client().fromFirestore(snapshot.data()!);
      List<TransactionModel> transactions = client.transactions ?? [];

      for (var transaction in transactions) {
        if (transaction.id == transactionId) {
          transactions.remove(transaction);
          await clientDoc.update({
            'transactions':
                transactions.map((trans) => trans.toFirestore()).toList()
          });
          print('success deleting transaction');
        } else {
          print('Not found');
        }
      }
    }
  }
}
