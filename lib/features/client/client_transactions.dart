import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:transaction_app/core/app_colors.dart';
import 'package:transaction_app/data/model/client.dart';
import 'package:transaction_app/data/model/transaction.dart';
import 'package:transaction_app/data/services/firestore_services.dart';
import 'package:transaction_app/features/client/widgets/edit_user_screen.dart';
import 'package:transaction_app/features/client/widgets/edit_user_transaction_screen.dart';
import 'package:transaction_app/features/shared/styled_button.dart';
import 'package:transaction_app/providers/client_provider.dart';

class ClientTransactions extends ConsumerStatefulWidget {
  final Client client;

  const ClientTransactions({
    required this.client,
    super.key,
  });

  @override
  ConsumerState<ClientTransactions> createState() => _ClientTransactionsState();
}

class _ClientTransactionsState extends ConsumerState<ClientTransactions> {
  @override
  Widget build(BuildContext context) {
    Client clientDetails = ref
        .watch(clientProviderProvider)
        .firstWhere((e) => (e == widget.client) ? true : false);
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
                              client: clientDetails,
                            )),
                  );
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem<String>(
                    value: 'Edit User',
                    child: Text('تعديل بينات العميل'),
                  ),
                ];
              },
              icon: const Icon(Icons.more_vert), // Three dots icon
            ),
          ),
        ],
        title: Text(clientDetails.name.toString()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: clientDetails.transactions!.length,
          itemBuilder: (context, index) {
            TransactionModel transaction = clientDetails.transactions![index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditUserTransactionScreen(
                              client: clientDetails,
                              transaction: transaction,
                            )));
              },
              child: Container(
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
                            ref
                                .read(clientProviderProvider.notifier)
                                .deleteTransaction(clientDetails, transaction);

                            FirestoreServices().deleteClientTransaction(
                                clientId: clientDetails.phoneNumber!,
                                transactionId: transaction.id!);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: AppColors.myRed,
                          )),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: StyledButton(
          onPressed: () {
            Navigator.pop(context); // Perform the pop
            ref.read(clientProviderProvider.notifier).deleteClient(
                clientDetails); // Perform the state update after pop
            FirestoreServices()
                .deleteClient(clientId: clientDetails.phoneNumber!);
          },
          text: 'حذف العميل'),
    );
  }
}
