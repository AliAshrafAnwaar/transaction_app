import 'package:transaction_app/data/model/transaction.dart';

class Client {
  List<TransactionModel>? transactions;
  String? phoneNumber;
  String? name;
  int? numberTransactions;

  Client(
      {this.name,
      this.phoneNumber,
      this.transactions,
      this.numberTransactions});

  // formate from Firebase
  Client fromFirestore(Map<String, dynamic> json) {
    return Client(
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      transactions: ((json['transactions'] != null)
              ? json['transactions'] as List<dynamic>
              : [])
          .map((dyn) =>
              TransactionModel().fromFirestore(dyn as Map<String, dynamic>))
          .toList(),
    );
  }

  // formate to fireBase
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'transactions': transactions?.map((trans) => trans.toFirestore()),
    };
  }

  // Add to Alltransactions and to Client
  void addClient(Client client) {
    for (var c in clients) {
      if (client.phoneNumber == c.phoneNumber) {
        c.transactions!.add(client.transactions![0]);
        allTransactions.insert(0, client.transactions![0]);
        return;
      }
    }
    clients.add(client);
    allTransactions.insert(0, client.transactions![0]);
    return;
  }

  // Delete Client From Client list
  void deleteClient(Client client) {
    for (var c in clients) {
      if (client.phoneNumber == c.phoneNumber) {
        clients.remove(c);
        print('Client deleted');
        return;
      }
    }
    print('Client not found');
    return;
  }

  // Delete transaction from transaction list of User
  void deleteTransaction(Client client, TransactionModel transaction) {
    print(client.transactions);
    client.transactions!.remove(transaction);
  }

  // Edite Client info
  void editClient(Client newClient, Client oldClient) {
    for (var c in clients) {
      if (c.phoneNumber == oldClient.phoneNumber) {
        // Directly update the fields of the existing object
        c.name = newClient.name;
        c.phoneNumber = newClient.phoneNumber;
        return;
      }
    }
    print('Client not found');
  }

  void editClientTransaction(Client client, TransactionModel newTransaction,
      TransactionModel oldTransaction) {
    for (Client c in clients) {
      if (c == client) {
        for (TransactionModel transaction in client.transactions!) {
          if (transaction == oldTransaction) {
            client.transactions!.remove(oldTransaction);
            client.transactions!.add(newTransaction);
          }
        }
      }
    }
  }
}

List<Client> clients = [
  Client(
    name: 'محمد',
    numberTransactions: 3,
    phoneNumber: '0155501234',
    transactions: trans1,
  ),
  Client(
    name: 'خالد',
    numberTransactions: 2,
    phoneNumber: '0123456789',
    transactions: trans2,
  ),
  Client(
    name: 'فاطمة',
    numberTransactions: 4,
    phoneNumber: '0119988776',
    transactions: trans3,
  ),
  Client(
    name: 'نور',
    numberTransactions: 1,
    phoneNumber: '0101234567',
    transactions: trans4,
  ),
];

List<TransactionModel> trans1 = [
  TransactionModel(
    id: "1", // Add the id field
    amount: 75,
    payMethod: 'بطاقة',
    type: 'سحب',
    phoneNumber: '0155501234',
    time: DateTime(2002),
  ),
  TransactionModel(
    id: "2", // Add the id field
    amount: 200,
    payMethod: 'تحويل',
    type: 'إيداع',
    phoneNumber: '0155501234',
    time: DateTime(2002),
  ),
  TransactionModel(
    id: "3", // Add the id field
    amount: 100,
    payMethod: 'تحويل',
    type: 'إيداع',
    phoneNumber: '0123456789',
    time: DateTime(2002),
  ),
  TransactionModel(
    id: "4", // Add the id field
    amount: 90,
    payMethod: 'نقدي',
    type: 'سحب',
    phoneNumber: '0119988776',
    time: DateTime(2002),
  ),
];

List<TransactionModel> trans2 = [
  TransactionModel(
    id: "5", // Add the id field
    amount: 50,
    payMethod: 'نقدي',
    type: 'شراء',
    phoneNumber: '0123456789',
    time: DateTime(2002),
  ),
  TransactionModel(
    id: "6", // Add the id field
    amount: 100,
    payMethod: 'تحويل',
    type: 'إيداع',
    phoneNumber: '0123456789',
    time: DateTime(2002),
  ),
];

List<TransactionModel> trans3 = [
  TransactionModel(
    id: "7", // Add the id field
    amount: 75,
    payMethod: 'بطاقة',
    type: 'سحب',
    phoneNumber: '0155501234',
    time: DateTime(2002),
  ),
  TransactionModel(
    id: "8", // Add the id field
    amount: 200,
    payMethod: 'تحويل',
    type: 'إيداع',
    phoneNumber: '0155501234',
    time: DateTime(2002),
  ),
  TransactionModel(
    id: "9", // Add the id field
    amount: 100,
    payMethod: 'تحويل',
    type: 'إيداع',
    phoneNumber: '0123456789',
    time: DateTime(2002),
  ),
  TransactionModel(
    id: "10", // Add the id field
    amount: 90,
    payMethod: 'نقدي',
    type: 'سحب',
    phoneNumber: '0119988776',
    time: DateTime(2002),
  ),
];

List<TransactionModel> trans4 = [
  TransactionModel(
    id: "11", // Add the id field
    amount: 100,
    payMethod: 'تحويل',
    type: 'إيداع',
    phoneNumber: '0123456789',
    time: DateTime(2002),
  ),
  TransactionModel(
    id: "12", // Add the id field
    amount: 90,
    payMethod: 'نقدي',
    type: 'سحب',
    phoneNumber: '0119988776',
    time: DateTime(2002),
  ),
];

List<TransactionModel> allTransactions = [
  TransactionModel(
    amount: 10050, // Between 10k and 15k
    payMethod: 'بطاقة',
    type: 'سحب',
    time: DateTime.now(), // 6 days ago
    phoneNumber: '0155501234',
  ),
  TransactionModel(
    amount: 14200, // Between 10k and 15k
    payMethod: 'تحويل',
    type: 'ايداع',
    time: DateTime.now().subtract(Duration(days: 5)), // 5 days ago
    phoneNumber: '0155501234',
  ),
  TransactionModel(
    amount: 12000, // Between 10k and 15k
    time: DateTime.now().subtract(Duration(days: 4)), // 4 days ago
    payMethod: 'تحويل',
    type: 'ايداع',
    phoneNumber: '0123456789',
  ),
  TransactionModel(
    amount: 10500, // Between 10k and 15k
    payMethod: 'نقدي',
    time: DateTime.now().subtract(Duration(days: 3)), // 3 days ago
    type: 'سحب',
    phoneNumber: '0119988776',
  ),
  TransactionModel(
    amount: 11500, // Between 10k and 15k
    payMethod: 'بطاقة',
    time: DateTime.now().subtract(Duration(days: 2)), // 2 days ago
    type: 'ايداع',
    phoneNumber: '0119988776',
  ),
  TransactionModel(
    amount: 14000, // Between 10k and 15k
    payMethod: 'نقدي',
    time: DateTime.now().subtract(Duration(days: 1)), // 1 day ago
    type: 'سحب',
    phoneNumber: '0119988776',
  ),
  TransactionModel(
    amount: 13500, // Between 10k and 15k
    time: DateTime.now(), // Today
    payMethod: 'بطاقة',
    type: 'ايداع',
    phoneNumber: '0119988776',
  ),
  TransactionModel(
    amount: 10100, // Between 10k and 15k
    payMethod: 'تحويل',
    time: DateTime.now().subtract(Duration(days: 2)), // 2 days ago
    type: 'ايداع',
    phoneNumber: '0123456789',
  ),
  // New transaction
  TransactionModel(
    amount: 14500, // Between 10k and 15k
    payMethod: 'نقدي',
    type: 'سحب',
    time: DateTime.now(), // 6 days ago
    phoneNumber: '0155501234',
  ),
  // Another new transaction
  TransactionModel(
    amount: 11000, // Between 10k and 15k
    payMethod: 'بطاقة',
    type: 'ايداع',
    time: DateTime.now().subtract(Duration(days: 3)), // 3 days ago
    phoneNumber: '0123456789',
  ),
];
