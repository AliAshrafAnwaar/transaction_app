import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String? phoneNumber;
  late final String? id;
  final double? amount;
  final String? type;
  final DateTime? time;
  final String? payMethod;

  TransactionModel(
      {this.amount,
      this.id,
      this.payMethod,
      this.type,
      this.phoneNumber,
      this.time});

  TransactionModel fromFirestore(Map<String, dynamic> json) {
    return TransactionModel(
        id: json['id'] as String,
        amount: json['amount'] as double,
        payMethod: json['payMethod'] as String,
        type: json['type'] as String,
        phoneNumber: json['phoneNumber'] as String,
        time: (json['time'] as Timestamp).toDate());
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'amount': amount,
      'payMethod': payMethod,
      'type': type,
      'phoneNumber': phoneNumber,
      'time': time
    };
  }
}
