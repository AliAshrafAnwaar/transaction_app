import 'package:flutter/material.dart';
import 'package:transaction_app/core/app_colors.dart';
import 'package:transaction_app/data/model/client.dart';
import 'package:transaction_app/data/model/transaction.dart';

class ClientTransactions extends StatefulWidget {
  final String name;
  final String phoneNumber;
  final Client client;

  const ClientTransactions({
    required this.phoneNumber,
    required this.name,
    required this.client,
    super.key,
  });

  @override
  State<ClientTransactions> createState() => _ClientTransactionsState();
}

class _ClientTransactionsState extends State<ClientTransactions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text(widget.name),
              const Expanded(child: SizedBox()),
              const Text('|'),
              const Expanded(child: SizedBox()),
              Text(widget.phoneNumber),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              itemCount: widget.client.transactions.length,
              itemBuilder: (context, index) {
                Transaction transaction = widget.client.transactions[index];
                return Container(
                    decoration: BoxDecoration(
                        color: AppColors.secondaryText.withOpacity(0.05),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('مبلغ العمليه: ${transaction.amount}'),
                        Text('طريقه الدفع: ${transaction.payMethod}'),
                        Text('نوع العمليه: ${transaction.type}'),
                      ],
                    ));
              }),
        ));
  }
}
