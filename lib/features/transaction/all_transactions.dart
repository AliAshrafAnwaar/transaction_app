import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transaction_app/data/model/transaction.dart';
import 'package:transaction_app/features/shared/styled_textField.dart';
import 'package:transaction_app/providers/all_transactions_provider.dart';
import 'package:transaction_app/providers/client_provider.dart';

class AllTransactions extends ConsumerStatefulWidget {
  const AllTransactions({super.key});

  @override
  ConsumerState<AllTransactions> createState() => _AllTransactionsState();
}

class _AllTransactionsState extends ConsumerState<AllTransactions> {
  late TextEditingController searchController;
  List<TransactionModel> filteredTransactions = [];
  String sortOption = 'date';
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();

    // Link search field with external search controller
    final appBarSearchController =
        ref.read(clientProviderProvider.notifier).getterSearchController();

    appBarSearchController.addListener(() {
      if (!_isDisposed) {
        searchController.text = appBarSearchController.text;
        _filterTransactions();
      }
    });

    searchController.addListener(() {
      if (!_isDisposed) _filterTransactions();
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    searchController.dispose();
    super.dispose();
  }

  void _filterTransactions() {
    final query = searchController.text.toLowerCase();
    final allTransactions = ref.read(allTransactionsProviderProvider).toList();

    setState(() {
      filteredTransactions = allTransactions
          .where((transaction) =>
              transaction.phoneNumber?.toLowerCase().contains(query) ?? false)
          .toList();
      _sortTransactions();
    });
  }

  void _sortTransactions() {
    setState(() {
      switch (sortOption) {
        case 'phoneNumber':
          filteredTransactions.sort(
              (a, b) => a.phoneNumber?.compareTo(b.phoneNumber ?? '') ?? 0);
          break;
        case 'amount':
          filteredTransactions
              .sort((a, b) => (a.amount ?? 0).compareTo(b.amount ?? 0));
          break;
        case 'date':
        default:
          filteredTransactions.sort((a, b) =>
              (b.time ?? DateTime(0)).compareTo(a.time ?? DateTime(0)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final allTransactions = ref.watch(allTransactionsProviderProvider).toList();

    if (searchController.text.isEmpty && filteredTransactions.isEmpty) {
      setState(() => filteredTransactions = allTransactions);
    }

    return SafeArea(
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              bool isWeb = constraints.maxWidth > 1024;

              if (isWeb) {
                return const SizedBox();
              } else {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildSearchAndSortBar(),
                );
              }
            },
          ),
          const SizedBox(height: 10),
          _buildTransactionList(),
        ],
      ),
    );
  }

  Widget _buildSearchAndSortBar() {
    return Row(
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
          alignment: Alignment.center,
          onChanged: (value) {
            if (value != null) {
              setState(() {
                sortOption = value;
                _sortTransactions();
              });
            }
          },
          items: const [
            DropdownMenuItem(
              value: 'date',
              child: Text('التاريخ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            DropdownMenuItem(
              value: 'phoneNumber',
              child: Text('رقم الهاتف',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            DropdownMenuItem(
              value: 'amount',
              child: Text('المبلغ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
          icon: const Icon(Icons.arrow_drop_down, color: Colors.blue),
          dropdownColor: Colors.white,
          underline: const SizedBox(),
          borderRadius: BorderRadius.circular(8),
        ),
      ],
    );
  }

  Widget _buildTransactionList() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.builder(
          itemCount: filteredTransactions.length,
          itemBuilder: (context, index) {
            final transaction = filteredTransactions[index];
            return _buildTransactionCard(transaction);
          },
        ),
      ),
    );
  }

  Widget _buildTransactionCard(TransactionModel transaction) {
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
                    fontWeight: FontWeight.bold, color: Colors.blue)),
            const SizedBox(height: 5),
            Text('نوع: ${transaction.type ?? ""}'),
            const SizedBox(height: 5),
            Text('المبلغ: ${transaction.amount ?? ""}'),
            const SizedBox(height: 5),
            Text(
                'تاريخ: ${transaction.time?.year ?? ""} / ${transaction.time?.month ?? ""} / ${transaction.time?.day ?? ""}'),
            Text(
              'الساعة: ${(transaction.time?.hour ?? 0) > 12 ? "${transaction.time!.hour - 12}:${transaction.time!.minute}" : "${transaction.time?.hour ?? 0}:${transaction.time?.minute ?? 0}"} ${(transaction.time?.hour ?? 0) > 12 ? "م" : "ص"}',
            ),
          ],
        ),
      ),
    );
  }
}
