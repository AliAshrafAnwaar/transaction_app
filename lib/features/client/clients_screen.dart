import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:transaction_app/core/app_colors.dart';
import 'package:transaction_app/data/model/client.dart';
import 'package:transaction_app/features/client/client_transactions.dart';
import 'package:transaction_app/providers/client_provider.dart';

class ClientsScreen extends ConsumerStatefulWidget {
  const ClientsScreen({super.key});

  @override
  ConsumerState<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends ConsumerState<ClientsScreen> {
  late TextEditingController searchController;
  String sortOption = 'name'; // Default sort option
  List<Client> filteredClients = [];

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    searchController.addListener(() {
      setState(() {}); // Rebuild on search input change
    });
  }

  @override
  void dispose() {
    searchController.dispose(); // Dispose of the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allClients = ref.watch(clientProviderProvider).toList();
    final query = searchController.text.toLowerCase();

    // Local function for filtering clients
    List<Client> filterClients() {
      return allClients.where((client) {
        return client.name!.toLowerCase().contains(query) ||
            client.phoneNumber!.contains(query);
      }).toList();
    }

    // Local function for sorting clients
    void sortClients(List<Client> clients) {
      if (sortOption == 'name') {
        clients.sort((a, b) => a.name!.compareTo(b.name!));
      } else if (sortOption == 'phone') {
        clients.sort((a, b) => a.phoneNumber!.compareTo(b.phoneNumber!));
      }
    }

    filteredClients = filterClients();
    sortClients(filteredClients);

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
          const Icon(Icons.more_horiz),
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
}
