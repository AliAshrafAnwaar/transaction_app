class Transaction {
  final String phoneNumber;
  late final String id;
  final double amount;
  final String type;
  final String payMethod;

  Transaction(
      {required this.amount,
      required this.payMethod,
      required this.type,
      required this.phoneNumber});

  void fromFirestore(Map<String, dynamic> json) {
    Transaction(
        amount: json['amount'],
        payMethod: json['payMethod'],
        type: json['type'],
        phoneNumber: json['phoneNumber']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'amount': amount,
      'payMethod': payMethod,
      'type': type,
      'phoneNumber': phoneNumber,
    };
  }

  // Adding transactions to global list and client-specific lists
  void addTransaction(Transaction transaction) {
    // Add to the global list
    // allTransactions.add(transaction);

    // You can also add this transaction to the respective client's transaction list
    // Here’s a hypothetical way to do that
    // for (var client in clients) {
    //   if (client.phoneNumber == transaction.phoneNumber) {
    //     client.transactions.add(transaction);
    //     client.numberTransactions =
    //         client.transactions.length; // Update transaction count
    //     break;
    //   }
    // }
  }
}
