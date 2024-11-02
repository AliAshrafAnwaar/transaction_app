import 'package:transaction_app/data/model/transaction.dart';

class Client {
  List<Transaction> transactions;
  final String phoneNumber;
  final String name;
  int numberTransactions;

  Client(
      {required this.name,
      required this.phoneNumber,
      required this.transactions,
      required this.numberTransactions});

  void fromFirestore(Map<String, dynamic> json) {
    Client(
        name: json['name'],
        numberTransactions: json['numberTransactions'],
        phoneNumber: json['id'],
        transactions: json['transactions']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'numberTransactions': numberTransactions,
      'phoneNumber': phoneNumber,
      'transactions': transactions
    };
  }

  void addClient(Client client) {
    print(client.phoneNumber);
    for (var c in clients) {
      print('${client.phoneNumber} + ${c.phoneNumber}');
      if (client.phoneNumber == c.phoneNumber) {
        c.transactions.add(client.transactions[0]);
        print(1);
        return;
      }
    }
    clients.add(client);
    print(2);
    return;
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

List<Transaction> trans1 = [
  Transaction(
    amount: 150,
    payMethod: 'نقدي',
    type: 'شراء',
    phoneNumber: '0155501234',
  ),
  Transaction(
    amount: 75,
    payMethod: 'بطاقة',
    type: 'سحب',
    phoneNumber: '0155501234',
  ),
  Transaction(
    amount: 200,
    payMethod: 'تحويل',
    type: 'إيداع',
    phoneNumber: '0155501234',
  ),
];

List<Transaction> trans2 = [
  Transaction(
    amount: 50,
    payMethod: 'نقدي',
    type: 'شراء',
    phoneNumber: '0123456789',
  ),
  Transaction(
    amount: 100,
    payMethod: 'تحويل',
    type: 'إيداع',
    phoneNumber: '0123456789',
  ),
];

List<Transaction> trans3 = [
  Transaction(
    amount: 120,
    payMethod: 'بطاقة',
    type: 'شراء',
    phoneNumber: '0119988776',
  ),
  Transaction(
    amount: 300,
    payMethod: 'تحويل',
    type: 'تحويل',
    phoneNumber: '0119988776',
  ),
  Transaction(
    amount: 90,
    payMethod: 'نقدي',
    type: 'سحب',
    phoneNumber: '0119988776',
  ),
  Transaction(
    amount: 50,
    payMethod: 'بطاقة',
    type: 'إيداع',
    phoneNumber: '0119988776',
  ),
];

List<Transaction> trans4 = [
  Transaction(
    amount: 25,
    payMethod: 'نقدي',
    type: 'شراء',
    phoneNumber: '0101234567',
  ),
];

List<Transaction> allTransactions = [];
