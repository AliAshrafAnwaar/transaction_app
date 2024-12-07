import 'package:flutter/material.dart';
import 'package:transaction_app/data/model/client.dart';
import 'package:transaction_app/data/model/transaction.dart';
import 'package:transaction_app/features/shared/styled_textField.dart';

class AllTransactions extends StatefulWidget {
  const AllTransactions({super.key});

  @override
  State<AllTransactions> createState() => _AllTransactionsState();
}

class _AllTransactionsState extends State<AllTransactions> {
  List<TransactionModel> filteredClients = [];
  final TextEditingController searchController = TextEditingController();
  String sortOption = 'date';

  @override
  void initState() {
    super.initState();
    filteredClients = List.from(allTransactions);
    searchController.addListener(() {
      filterClients();
    });
  }

  void filterClients() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredClients = allTransactions.where((transaction) {
        return transaction.phoneNumber!.toLowerCase().contains(query);
      }).toList();
      sortClients();
    });
  }

  void sortClients() {
    setState(() {
      if (sortOption == 'phoneNumber') {
        filteredClients
            .sort((a, b) => a.phoneNumber!.compareTo(b.phoneNumber!));
      } else if (sortOption == 'amount') {
        filteredClients.sort((a, b) => a.amount!.compareTo(b.amount!));
      } else if (sortOption == 'date') {
        filteredClients
            .sort((a, b) => b.time!.compareTo(a.time!)); // Newest first
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar and Dropdown
            Row(
              children: [
                Expanded(
                  child: StyledTextField(
                    controller: searchController,
                    hint: 'ابحث عن عمليه',
                    icon: Icons.search,
                  ),
                ),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: sortOption,
                  padding: const EdgeInsets.all(0),
                  alignment: Alignment.center,
                  isDense: false, // Reduces internal padding
                  focusColor: Colors.transparent,
                  onChanged: (value) {
                    setState(() {
                      sortOption = value!;
                      sortClients();
                    });
                  },
                  items: const [
                    DropdownMenuItem(
                      value: 'date',
                      child: Text(
                        'التاريخ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'phoneNumber',
                      child: Text(
                        'رقم الهاتف',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'amount',
                      child: Text(
                        'المبلغ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.blue),
                  dropdownColor: Colors.white,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  underline:
                      const SizedBox(), // Removed default underline for a cleaner look
                  borderRadius: BorderRadius.circular(
                      8), // Smooth border for the dropdown
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Transactions List
            Expanded(
              child: ListView.builder(
                itemCount: filteredClients.length,
                itemBuilder: (context, index) {
                  final transaction = filteredClients[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('رقم الهاتف: ${transaction.phoneNumber}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue)),
                          const SizedBox(height: 5),
                          Text('نوع: ${transaction.type}'),
                          const SizedBox(height: 5),
                          Text('المبلغ: ${transaction.amount}'),
                          const SizedBox(height: 5),
                          Text(
                              'تاريخ: ${transaction.time!.year} / ${transaction.time!.month} / ${transaction.time!.day}'),
                          Text(
                            'الساعة: ${(transaction.time!.hour > 12) ? '${transaction.time!.hour - 12}:${transaction.time!.minute}' : '${transaction.time!.hour}:${transaction.time!.minute}'} ${(transaction.time!.hour > 12) ? 'م' : 'ص'}',
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
