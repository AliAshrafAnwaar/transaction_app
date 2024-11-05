import 'package:flutter/material.dart';
import 'package:transaction_app/data/model/client.dart';
import 'package:transaction_app/features/shared/styled_button.dart';
import 'package:transaction_app/features/shared/styled_textField.dart';

class EditUserScreen extends StatefulWidget {
  const EditUserScreen({
    required this.client,
    super.key,
  });

  final Client client;

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  // TextEditingControllers to manage the input fields
  late TextEditingController _nameController;
  late TextEditingController _phoneNumberController;

  // Form key to handle form validation
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Initialize controllers with the client's current data
    _nameController = TextEditingController(text: widget.client.name);
    _phoneNumberController =
        TextEditingController(text: widget.client.phoneNumber);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  // Function to handle form submission   -----------------------------------------------------------------------------------
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, proceed with the update
      Client client = Client(
          name: _nameController.text,
          phoneNumber: _phoneNumberController.text,
          transactions: widget.client.transactions,
          numberTransactions: widget.client.numberTransactions);
      print("new: ${client.name} old: ${widget.client.name}");
      widget.client.editClient(client, widget.client);
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
          title: const Text("تعديل بيانات العميل"),
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
                      child: Text("الاسم"),
                    ),
                    SizedBox(
                      width: 250,
                      child: StyledTextField(
                        controller: _nameController,
                        hint: "الاسم",
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
                      child: Text("رقم الهاتف"),
                    ),
                    SizedBox(
                      width: 250,
                      child: StyledTextField(
                        controller: _phoneNumberController,
                        hint: "رقم الهاتف",
                        icon: Icons.phone,
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
