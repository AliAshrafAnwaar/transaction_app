import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:transaction_app/data/model/client.dart';
import 'package:transaction_app/data/model/transaction.dart';
import 'package:transaction_app/features/shared/styled_button.dart';
import 'package:transaction_app/features/shared/styled_textField.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController paymentMethodController = TextEditingController();

  final DateTime? dateTime = DateTime.now();

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
      Transaction transaction = Transaction(
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
      ins.addClient(Client(
          name: name,
          phoneNumber: phoneNumber,
          transactions: [transaction],
          numberTransactions: 5));

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
        title: const Text("تسجيل عمليه السحب"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey, // Wrap the inputs in a Form widget
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              StyledTextField(
                hint: "الاسم",
                icon: Icons.person,
                controller: nameController,
              ),
              StyledTextField(
                hint: "رقم الهاتف",
                icon: Icons.phone,
                controller: phoneController,
              ),
              StyledTextField(
                hint: "المبلغ",
                icon: Icons.money,
                controller: amountController,
              ),
              StyledTextField(
                hint: "نوع العمليه",
                icon: Icons.type_specimen,
                controller: typeController,
                options: const ["ايداع", "سحب"],
              ),
              GestureDetector(
                onTap: () async {
                  final DateTime? dateTime =
                      await showOmniDateTimePicker(context: context);

                  // Use dateTime here
                  if (dateTime != null) {
                    dateController.text =
                        '${dateTime.year}/${dateTime.month}/${dateTime.day}  الساعه: ${(dateTime.hour > 12) ? '${dateTime.hour - 12}:${dateTime.minute}' : '${dateTime.hour} : ${dateTime.minute}'}${(dateTime.hour > 12) ? 'م' : 'ص'}';
                  }

                  debugPrint('dateTime: $dateTime');
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
              StyledTextField(
                hint: "طريقه الدفع",
                icon: Icons.directions,
                controller: paymentMethodController,
              ),
              const SizedBox(height: 30),
              StyledButton(
                onPressed: onSubmit, // Call the submit function
                text: "تسجيل العمليه",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
