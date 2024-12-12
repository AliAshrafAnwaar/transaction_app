import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:transaction_app/data/model/client.dart';
import 'package:transaction_app/data/model/transaction.dart';
import 'package:transaction_app/features/shared/styled_button.dart';
import 'package:transaction_app/features/shared/styled_textfield.dart';
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

      // Clear the text fields after submission if needed
      nameController.clear();
      phoneController.clear();
      amountController.clear();
      typeController.clear();
      dateController.clear();
      paymentMethodController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey, // Wrap the inputs in a Form widget
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
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
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    titlePadding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    contentPadding: const EdgeInsets.all(10),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    title: const Text("اختر نوع العملية"),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: ["ايداع", "سحب"].map((option) {
                                        return ListTile(
                                          title: Text(option),
                                          onTap: () {
                                            typeController.text = option;
                                            Navigator.pop(context);
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  );
                                },
                              );
                            },
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            child: AbsorbPointer(
                              child: StyledTextField(
                                hint: "نوع العمليه",
                                icon: Icons.type_specimen,
                                controller: typeController,
                                options: const ["ايداع", "سحب"],
                              ),
                            ),
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
                              dateTime = await showOmniDateTimePicker(
                                context: context,
                                constraints: BoxConstraints(
                                    maxHeight: 1000, maxWidth: 500),
                                is24HourMode: false, // Use 12-hour mode
                                isShowSeconds: false, // Hide seconds picker
                                borderRadius: BorderRadius.circular(20),
                              );
                              final dateFormatter = DateFormat(
                                  'dd/MM/yy | h:ma',
                                  'ar'); // Arabic date format

                              // Use dateTime here
                              if (dateTime != null) {
                                final arabicDate =
                                    dateFormatter.format(dateTime!);
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
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            titlePadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            contentPadding: const EdgeInsets.all(10),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            title: const Text("طريقه الدفع"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: ["محفظه", "كاش", "تحويل بنكي", "فيزا"]
                                  .map((option) {
                                return ListTile(
                                  title: Text(option),
                                  onTap: () {
                                    paymentMethodController.text = option;
                                    Navigator.pop(context);
                                  },
                                );
                              }).toList(),
                            ),
                          );
                        },
                      );
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: AbsorbPointer(
                      child: StyledTextField(
                        hint: "طريقه الدفع",
                        icon: Icons.type_specimen,
                        controller: paymentMethodController,
                        options: const ["محفظه", "كاش", "تحويل بنكي", "فيزا"],
                      ),
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
        ),
      ),
    );
  }
}
