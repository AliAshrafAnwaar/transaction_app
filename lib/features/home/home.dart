import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:transaction_app/core/app_colors.dart';
import 'package:transaction_app/data/model/client.dart';
import 'package:transaction_app/data/model/transaction.dart';
import 'package:transaction_app/features/home/styled_texfield_dialog.dart';
import 'package:transaction_app/features/shared/styled_button.dart';
import 'package:transaction_app/features/shared/styled_textfield.dart';
import 'package:transaction_app/providers/client_provider.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});
  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController paymentMethodController = TextEditingController();

  DateTime? dateTime;

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // Add a global key for form validation

  @override
  void dispose() {
    // Dispose controllers when the widget is removed from the widget tree
    nameController.dispose();
    phoneController.dispose();
    amountController.dispose();
    typeController.dispose();
    dateController.dispose();
    paymentMethodController.dispose();
    super.dispose();
  }

  void onSubmit() {
    if (!_formKey.currentState!.validate()) {
      return; // Exit early if form is invalid
    }

    // Retrieve and parse input values
    final name = nameController.text;
    final phoneNumber = phoneController.text;
    final amount = double.tryParse(amountController.text) ?? 0.0;
    final type = typeController.text;
    final date = DateTime.parse(dateController.text);
    final payMethod = paymentMethodController.text;

    // Create TransactionModel and Client instances
    final transaction = TransactionModel(
      id: date.microsecondsSinceEpoch.toString(),
      amount: amount,
      payMethod: payMethod,
      type: type,
      time: date,
      phoneNumber: phoneNumber,
    );

    final client = Client(
      name: name,
      phoneNumber: phoneNumber,
      transactions: [transaction],
      numberTransactions: 5,
    );

    // Add the client using the provider
    ref.read(clientProviderProvider.notifier).addClient(client);

    // Clear input fields
    _clearInputFields();
  }

  void _clearInputFields() {
    nameController.clear();
    phoneController.clear();
    amountController.clear();
    typeController.clear();
    dateController.clear();
    paymentMethodController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _formKey, // Wrap the inputs in a Form widget
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    "تسجيل عمليه",
                    style: TextStyle(
                      color: AppColors.hintColor,
                      fontSize: 26,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: StyledTextField(
                      hint: "الاسم",
                      icon: Icons.person,
                      controller: nameController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: StyledTextField(
                      hint: "رقم الهاتف",
                      icon: Icons.phone,
                      controller: phoneController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Flexible(
                          child: StyledTextfieldDialog(
                              hint: 'نوع العمليه',
                              list: const ["ايداع", "سحب"],
                              icon: const Icon(Icons.type_specimen),
                              controller: typeController),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Flexible(
                            child: StyledTextfieldDialog(
                                hint: "التاريخ",
                                icon: const Icon(Icons.timelapse),
                                controller: dateController)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: StyledTextField(
                      hint: "المبلغ",
                      icon: Icons.money,
                      controller: amountController,
                    ),
                  ),
                  StyledTextfieldDialog(
                    hint: "طريقه الدفع",
                    icon: const Icon(Icons.payment),
                    controller: paymentMethodController,
                    list: const ["محفظه", "كاش", "تحويل بنكي", "فيزا"],
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: StyledButton(
                      onPressed: onSubmit, // Call the submit function
                      text: "تسجيل العمليه",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
