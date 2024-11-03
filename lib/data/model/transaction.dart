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
}
