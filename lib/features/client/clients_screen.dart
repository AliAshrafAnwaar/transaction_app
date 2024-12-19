import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transaction_app/data/model/client.dart';
import 'package:transaction_app/features/client/client_transactions.dart';
import 'package:transaction_app/features/shared/styled_textField.dart';
import 'package:transaction_app/providers/client_provider.dart';

class ClientsScreen extends ConsumerStatefulWidget {
  const ClientsScreen({super.key});

  @override
  ConsumerState<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends ConsumerState<ClientsScreen> {
  late TextEditingController searchController;
  bool _isDisposed = false; // Track if the widget is disposed

  bool isloading = false;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();

    // Initialize the controller with the provider's current value.
    final appBarSearchController =
        ref.read(clientProviderProvider.notifier).getterSearchController();

    // Add listener to update the provider whenever the text changes.
    appBarSearchController.addListener(() {
      if (!_isDisposed) {
        setState(() {
          searchController.text = appBarSearchController.text;
        });
      }
    });

    searchController.addListener(() {
      if (!_isDisposed) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _isDisposed = true; // Mark as disposed to prevent updates
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use Consumer to keep searchController in sync with provider's state.
    ref.listen<String>(
      clientProviderProvider.notifier
          .select((notifier) => notifier.getterSearchController().text),
      (previous, next) {
        if (searchController.text != next && !_isDisposed) {
          searchController.text = next; // Sync searchController.
        }
      },
    );

    final allClients = ref.watch(clientProviderProvider).toList();
    final filteredClients = _filterAndSortClients(allClients);

    if (isloading == false && allClients.isEmpty) {
      ref.read(clientProviderProvider.notifier).loadClients().whenComplete(() {
        setState(() {
          isloading = true;
        });
      });
    }

    return (isloading || allClients.isNotEmpty)
        ? (ref.watch(clientProviderProvider).isEmpty)
            ? const Center(
                child: Text(
                  'يوجد مشكله بالاتصال',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
            : SafeArea(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    bool isWeb = constraints.maxWidth > 1024;

                    if (isWeb) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            _buildClientList(filteredClients),
                          ],
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: StyledTextField(
                              hint: 'البحث عن',
                              icon: Icons.person,
                              controller: searchController,
                            ),
                          ),
                          _buildClientList(filteredClients),
                        ],
                      );
                    }
                  },
                ),
              )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }

  List<Client> _filterAndSortClients(List<Client> clients) {
    final query = searchController.text.toLowerCase();
    final filteredClients = clients.where((client) {
      return client.name!.toLowerCase().contains(query) ||
          client.phoneNumber!.contains(query);
    }).toList();

    filteredClients.sort((a, b) => a.name!.compareTo(b.name!)); // Sort by name
    return filteredClients;
  }

  Widget _buildClientList(List<Client> filteredClients) {
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
      child: RefreshIndicator(
        onRefresh: ref.read(clientProviderProvider.notifier).loadClients,
        child: ListView.builder(
          itemCount: filteredClients.length,
          itemBuilder: (context, index) {
            final client = filteredClients[index];
            return _buildClientTile(client);
          },
        ),
      ),
    );
  }

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
