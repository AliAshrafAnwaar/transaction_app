import 'package:flutter/material.dart';
import 'package:transaction_app/core/app_colors.dart';
import 'package:transaction_app/data/model/client.dart';
import 'package:transaction_app/data/model/transaction.dart';

class AllTransactions extends StatefulWidget {
  const AllTransactions({super.key});

  @override
  State<AllTransactions> createState() => _AllTransactionsState();
}

class _AllTransactionsState extends State<AllTransactions> {
  List<Transaction> filteredClients = [];
  final TextEditingController searchController = TextEditingController();
  String sortOption = 'phoneNumber'; // Default sort option

  @override
  void initState() {
    super.initState();
    filteredClients =
        List.from(allTransactions); // Initialize with all transactions

    // Add listener to search controller
    searchController.addListener(() {
      filterClients();
    });
  }

  void filterClients() {
    String query = searchController.text.toLowerCase();
    setState(() {
      // Filter transactions based on the query
      filteredClients = allTransactions.where((transaction) {
        return transaction.phoneNumber.toLowerCase().contains(query);
      }).toList();

      sortClients(); // Sort the filtered transactions
    });
  }

  void sortClients() {
    if (sortOption == 'phoneNumber') {
      filteredClients.sort((a, b) => a.phoneNumber.compareTo(b.phoneNumber));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: 'ابحث عمليه',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 5),
          const Icon(Icons.more_horiz),
          const SizedBox(height: 5),

          // Transaction List
          Expanded(
            child: ListView.builder(
              itemCount: filteredClients.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.secondaryText.withOpacity(0.05),
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                    ),
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'رقم الهاتف: ${filteredClients[index].phoneNumber}'),
                        const SizedBox(height: 5),
                        Text('نوع: ${filteredClients[index].type}'),
                        const SizedBox(height: 5),
                        Text('المبلغ: ${filteredClients[index].amount}'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose(); // Dispose of the controller
    super.dispose();
  }
}
