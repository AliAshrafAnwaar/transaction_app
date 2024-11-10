import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:transaction_app/core/app_colors.dart';

class StyledTextField extends StatefulWidget {
  const StyledTextField(
      {required this.hint,
      required this.icon,
      this.isPassword,
      this.controller,
      this.timeCheck,
      this.password,
      this.options,
      super.key});

  final String hint;
  final IconData icon;
  final bool? isPassword;
  final TextEditingController? controller;
  final TextEditingController? password;
  final bool? timeCheck;
  final List<String>? options; // List of options for selection

  @override
  State<StyledTextField> createState() => _StyledTextFieldState();
}

class _StyledTextFieldState extends State<StyledTextField> {
  bool? isPasswordChecker;

  final _formKey = GlobalKey<FormState>();

  void validation() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context);
    }
  }

  @override
  void initState() {
    super.initState();
    isPasswordChecker =
        isPasswordChecker ?? (widget.isPassword == true ? true : false);
  }

  // Function to show options dialog
  void _showOptionsDialog() {
    if (widget.options != null && widget.options!.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('اختر ${widget.hint}'),
            children: widget.options!.map((option) {
              return SimpleDialogOption(
                onPressed: () {
                  setState(() {
                    widget.controller?.text = option;
                  });
                  Navigator.pop(context);
                },
                child: Text(option),
              );
            }).toList(),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        style: Theme.of(context).textTheme.bodyMedium,
        controller: widget.controller,
        readOnly: widget.options != null ||
            widget.timeCheck ==
                true, // Make it read-only if options are provided
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter ${widget.hint}';
          } else if (value.length < 3 && widget.hint == "Full Name") {
            return 'Please enter at least 3 in ${widget.hint}';
          } else if (widget.hint == "E-mail" &&
              !value.toLowerCase().contains('.com')) {
            return "Invalid Email";
          } else if (widget.hint == "Password" && value.length < 8) {
            return "${widget.hint} must be at least 8 digits";
          } else if (widget.hint == "Confirm Password" &&
              widget.password?.text != value) {
            return ("Doesn't match");
          }
          return null;
        },
        obscureText: isPasswordChecker!,
        decoration: InputDecoration(
          hintText: widget.hint,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          labelStyle: Theme.of(context).textTheme.headlineMedium,
          hintStyle: Theme.of(context).textTheme.bodySmall,
          errorStyle: Theme.of(context).textTheme.bodyLarge,
          prefixIcon: Icon(
            widget.icon,
            color: AppColors.hintColor,
            size: 20,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: AppColors.hintColor,
              width: 1,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: AppColors.hintColor,
            ),
          ),
          focusColor: AppColors.primaryText,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: AppColors.primaryText,
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: AppColors.myRed,
              width: 1,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: AppColors.myRed,
              width: 1,
            ),
          ),
          suffixIcon: widget.isPassword == true
              ? IconButton(
                  icon: Icon(
                    isPasswordChecker!
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: AppColors.hintColor,
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordChecker = !isPasswordChecker!;
                    });
                  })
              : const SizedBox(),
        ),
        onTap: widget.options != null
            ? _showOptionsDialog
            : null, // Show dialog on tap
      ),
    );
  }
}
