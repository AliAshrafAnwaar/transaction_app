import 'package:flutter/material.dart';
import 'package:transaction_app/core/app_colors.dart';
import 'package:transaction_app/data/model/client.dart';
import 'package:transaction_app/features/display/client_transactions.dart';

class Display extends StatefulWidget {
  const Display({super.key});

  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  List<Client> filteredClients = clients; // List to hold filtered clients
  final TextEditingController searchController = TextEditingController();
  String sortOption = 'name'; // Default sort option

  @override
  void initState() {
    super.initState();
    // Add listener to search controller
    searchController.addListener(() {
      filterClients();
    });
  }

  void filterClients() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredClients = clients.where((client) {
        return client.name!.toLowerCase().contains(query) ||
            client.phoneNumber!.contains(query);
      }).toList();
      sortClients(); // Sort the filtered clients
    });
  }

  void sortClients() {
    if (sortOption == 'name') {
      filteredClients.sort((a, b) => a.name!.compareTo(b.name!));
    } else if (sortOption == 'phone') {
      filteredClients.sort((a, b) => a.phoneNumber!.compareTo(b.phoneNumber!));
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
                labelText: 'ابحث عن عميل',
                border: OutlineInputBorder(),
              ),
            ),
          ),

          const SizedBox(height: 5),
          Icon(Icons.more_horiz),
          const SizedBox(height: 5),

          // Client List
          Expanded(
            child: ListView.builder(
              itemCount: filteredClients.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ClientTransactions(
                          client: filteredClients[index],
                          name: filteredClients[index].name!,
                          phoneNumber: filteredClients[index].phoneNumber!,
                        ),
                      ),
                    );
                  },
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
                        Text('الاسم: ${filteredClients[index].name}'),
                        Text(
                            'رقم الهاتف: ${filteredClients[index].phoneNumber}'),
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
