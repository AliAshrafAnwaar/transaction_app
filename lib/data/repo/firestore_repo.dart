import 'package:transaction_app/data/model/client.dart';
import 'package:transaction_app/data/services/firestore_services.dart';

class FirestoreRepo {
  //Instance for calling FireStoreServices
  FirestoreServices firestoreIns = FirestoreServices();

  //GET Data Only Once
  Future<Set<Client>> loadData() async {
    return await firestoreIns.loadData();
  }

  //ADD
  Future<void> addClient(Client client) async {
    await firestoreIns.addClient(client);
  }

  //edit

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
