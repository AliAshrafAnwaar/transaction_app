import 'package:flutter/material.dart';
import 'package:transaction_app/core/app_colors.dart';
import 'package:transaction_app/data/model/client.dart';
import 'package:transaction_app/data/model/transaction.dart';
import 'package:transaction_app/features/display/edit_user_screen.dart';
import 'package:transaction_app/features/shared/styled_button.dart';

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
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: PopupMenuButton<String>(
              onSelected: (String choice) {
                if (choice == 'Edit User') {
                  // Navigate to EditUserScreen when the item is selected
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditUserScreen(
                              client: widget.client,
                            )),
                  );
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<String>(
                    value: 'Edit User',
                    child: Text('تعديل بينات العميل'),
                  ),
                ];
              },
              icon: Icon(Icons.more_vert), // Three dots icon
            ),
          ),
        ],
        title: Text(widget.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: widget.client.transactions!.length,
          itemBuilder: (context, index) {
            Transaction transaction = widget.client.transactions![index];
            return Container(
              decoration: BoxDecoration(
                  color: AppColors.secondaryText.withOpacity(0.05),
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('مبلغ العمليه: ${transaction.amount}'),
                      Text('طريقه الدفع: ${transaction.payMethod}'),
                      Text('نوع العمليه: ${transaction.type}'),
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: IconButton(
                        onPressed: () {
                          widget.client
                              .deleteTransaction(widget.client, transaction);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: AppColors.myRed,
                        )),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: StyledButton(
          onPressed: () {
            widget.client.deleteClient(widget.client);
          },
          text: 'حذف العميل'),
    );
  }
}
