class Transaction {
  final String phoneNumber;
  late final int? id;
  final double amount;
  final String type;
  final DateTime time;
  final String payMethod;

  Transaction(
      {required this.amount,
      this.id,
      required this.payMethod,
      required this.type,
      required this.phoneNumber,
      required this.time});

  void fromFirestore(Map<String, dynamic> json) {
    Transaction(
        amount: json['amount'],
        payMethod: json['payMethod'],
        type: json['type'],
        phoneNumber: json['phoneNumber'],
        time: json['time']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'amount': amount,
      'payMethod': payMethod,
      'type': type,
      'phoneNumber': phoneNumber,
      'time': time
    };
  }
}
