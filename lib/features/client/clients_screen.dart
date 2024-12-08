import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    searchController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  /// Filters clients based on the search query.
  List<Client> filterClients(List<Client> clients) {
    final query = searchController.text.toLowerCase();
    return clients.where((client) {
      return client.name!.toLowerCase().contains(query) ||
          client.phoneNumber!.contains(query);
    }).toList();
  }

  /// Sorts clients based on the selected sort option.
  void sortClients(List<Client> clients) {
    if (sortOption == 'name') {
      clients.sort((a, b) => a.name!.compareTo(b.name!));
    } else if (sortOption == 'phone') {
      clients.sort((a, b) => a.phoneNumber!.compareTo(b.phoneNumber!));
    }
  }

  @override
  Widget build(BuildContext context) {
    final allClients = ref.watch(clientProviderProvider).toList();
    filteredClients = filterClients(allClients);
    sortClients(filteredClients);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSearchBar(),
            const SizedBox(height: 5),
            _buildClientList(),
          ],
        ),
      ),
    );
  }

  /// Builds the search bar widget.
  Widget _buildSearchBar() {
    return TextField(
      controller: searchController,
      decoration: const InputDecoration(
        labelText: 'ابحث عن عميل',
        border: OutlineInputBorder(),
      ),
    );
  }

  /// Builds the list of clients.
  Widget _buildClientList() {
    if (filteredClients.isEmpty) {
      return const Expanded(
        child: Center(
          child: Text(
            'لم يتم العثور على عملاء',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: filteredClients.length,
        itemBuilder: (context, index) {
          final client = filteredClients[index];
          return _buildClientTile(client);
        },
      ),
    );
  }

  /// Builds a single client tile.
  Widget _buildClientTile(Client client) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 2,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ClientTransactions(client: client),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('الاسم: ${client.name}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue)),
              const SizedBox(height: 5),
              Text('رقم الهاتف: ${client.phoneNumber}'),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
