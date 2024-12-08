import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:transaction_app/core/app_colors.dart';
import 'package:transaction_app/data/model/client.dart';
import 'package:transaction_app/data/model/transaction.dart';
import 'package:transaction_app/data/services/firestore_services.dart';
import 'package:transaction_app/features/shared/styled_button.dart';
import 'package:transaction_app/features/shared/styled_textField.dart';
import 'package:transaction_app/providers/client_provider.dart';
import 'package:intl/intl.dart';

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
    if (_formKey.currentState!.validate()) {
      // Validate the form

      // Retrieve the text from the controllers
      String name = nameController.text;
      String phoneNumber = phoneController.text;
      double amount = double.parse(amountController.text);
      String type = typeController.text;
      DateTime date = dateTime!;
      String payMethod = paymentMethodController.text;

      // Here you can add logic to process the input, e.g., save it to a database
      TransactionModel transaction = TransactionModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          amount: amount,
          payMethod: payMethod,
          type: type,
          time: date,
          phoneNumber: phoneNumber);
      Client ins = Client(
          name: name,
          phoneNumber: phoneNumber,
          transactions: [transaction],
          numberTransactions: 5);

      ref.read(clientProviderProvider.notifier).addClient(ins);

      FirestoreServices test = FirestoreServices();
      test.addClient(client: ins);

      // Clear the text fields after submission if needed
      nameController.clear();
      phoneController.clear();
      amountController.clear();
      typeController.clear();
      dateController.clear();
      paymentMethodController.clear();
    }
  }

  String selectedType = 'ايداع';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "تسجيل العمليه",
          style: TextStyle(color: Color.fromARGB(255, 54, 54, 54)),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _formKey, // Wrap the inputs in a Form widget
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                      child: StyledTextField(
                        hint: "نوع العمليه",
                        icon: Icons.type_specimen,
                        controller: typeController,
                        options: const ["ايداع", "سحب"],
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Flexible(
                      child: InkWell(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        onTap: () async {
                          dateTime =
                              await showOmniDateTimePicker(context: context);
                          final dateFormatter = DateFormat(
                              'dd/MM/yy | h:ma', 'ar'); // Arabic date format

                          // Use dateTime here
                          if (dateTime != null) {
                            final arabicDate = dateFormatter.format(dateTime!);
                            dateController.text = arabicDate;
                          }
                        },
                        child: AbsorbPointer(
                          child: StyledTextField(
                            hint: 'التاريخ',
                            icon: Icons.timelapse,
                            timeCheck: true,
                            controller: dateController,
                          ),
                        ),
                      ),
                    ),
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: StyledTextField(
                  hint: "طريقه الدفع",
                  icon: Icons.directions,
                  controller: paymentMethodController,
                ),
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
    );
  }
}
