import 'package:flutter/material.dart';
import 'package:transaction_app/data/model/client.dart';
import 'package:transaction_app/data/model/transaction.dart';
import 'package:transaction_app/features/shared/styled_button.dart';
import 'package:transaction_app/features/shared/styled_textField.dart';

class EditUserTransactionScreen extends StatefulWidget {
  const EditUserTransactionScreen({
    required this.client,
    required this.transaction,
    super.key,
  });

  final Client client;
  final Transaction transaction;

  @override
  State<EditUserTransactionScreen> createState() =>
      _EditUserTransactionScreenState();
}

class _EditUserTransactionScreenState extends State<EditUserTransactionScreen> {
  // TextEditingControllers to manage the input fields
  late TextEditingController _amountController;
  late TextEditingController _payMethodController;
  late TextEditingController _typeController;

  // Form key to handle form validation
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Initialize controllers with the client's current data
    _amountController =
        TextEditingController(text: widget.transaction.amount.toString());
    _payMethodController =
        TextEditingController(text: widget.transaction.payMethod);
    _typeController = TextEditingController(text: widget.transaction.type);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _payMethodController.dispose();
    super.dispose();
  }

  // Function to handle form submission   -----------------------------------------------------------------------------------
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, proceed with the update
      Transaction transaction = Transaction(
          amount: double.parse(_amountController.text),
          payMethod: _payMethodController.text,
          type: _typeController.text,
          time: DateTime.now(),
          phoneNumber: widget.client.phoneNumber!);
      widget.client
          .editTransaction(widget.client, transaction, widget.transaction);
      print("Form is valid. Proceed with updating user data.");
    } else {
      // If the form is invalid, show an error
      print("Form is invalid. Please correct the errors.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("تعديل بيانات المعامله"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey, // Attach the form key
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 70,
                      child: Text("مبلغ"),
                    ),
                    SizedBox(
                      width: 250,
                      child: StyledTextField(
                        controller: _amountController,
                        hint: "مبلغ",
                        icon: Icons.person,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 70,
                      child: Text("الدفع"),
                    ),
                    SizedBox(
                      width: 250,
                      child: StyledTextField(
                        controller: _payMethodController,
                        hint: "الدفع",
                        icon: Icons.phone,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 70,
                      child: Text("نوع"),
                    ),
                    SizedBox(
                      width: 250,
                      child: StyledTextField(
                        controller: _typeController,
                        hint: "نوع",
                        icon: Icons.person,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(child: SizedBox()),
                    Expanded(
                      child: StyledButton(
                        onPressed:
                            _submitForm, // Call _submitForm on button press
                        text: 'تعديل',
                      ),
                    ),
                    Expanded(child: SizedBox()),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
