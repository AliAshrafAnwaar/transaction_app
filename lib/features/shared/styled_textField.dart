import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transaction_app/core/app_colors.dart';
import 'package:transaction_app/providers/client_provider.dart';

class StyledTextField extends ConsumerStatefulWidget {
  const StyledTextField(
      {required this.hint,
      required this.icon,
      this.isPassword,
      this.controller,
      this.timeCheck,
      this.readonly,
      this.password,
      this.isWhite,
      this.isNotifier,
      super.key});

  final bool? readonly;
  final String hint;
  final IconData icon;
  final bool? isPassword;
  final bool? isNotifier;
  final TextEditingController? controller;
  final TextEditingController? password;
  final bool? timeCheck;
  final bool? isWhite;

  @override
  ConsumerState<StyledTextField> createState() => _StyledTextFieldState();
}

class _StyledTextFieldState extends ConsumerState<StyledTextField> {
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

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (widget.isNotifier == true)
          ? (e) {
              ref
                  .read(clientProviderProvider.notifier)
                  .setterSearchController(widget.controller!);
            }
          : null,
      cursorColor: (widget.isWhite == true) ? Colors.white : null,
      style: (widget.isWhite == true)
          ? TextStyle(color: Colors.white)
          : Theme.of(context).textTheme.bodyMedium,
      controller: widget.controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'برجاء ادخال ${widget.hint}';
        } else if (value.length < 3 && widget.hint == "الاسم") {
          return 'برجاء ادخال علي الاقل 3 في ${widget.hint}';
        } else if (value.length != 11 && widget.hint == "رقم الهاتف") {
          return '${widget.hint} غير صحيح ';
        } else if (value.contains("+") && widget.hint == "رقم الهاتف") {
          return '${widget.hint} يبدأ ب 01';
        }
        return null;
      },
      readOnly: widget.readonly ?? false,
      obscureText: isPasswordChecker!,
      decoration: InputDecoration(
        isDense: (widget.isWhite == true) ? true : false,
        hintText: widget.hint,
        contentPadding: (widget.isWhite == true)
            ? EdgeInsets.all(0)
            : const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        labelStyle: (widget.isWhite == true)
            ? TextStyle(color: Colors.white)
            : Theme.of(context).textTheme.headlineMedium,
        hintStyle: (widget.isWhite == true)
            ? TextStyle(color: Colors.white.withOpacity(0.5))
            : Theme.of(context).textTheme.bodySmall,
        errorStyle: const TextStyle(color: Colors.red),
        prefixIcon: Icon(
          widget.icon,
          color: (widget.isWhite == true) ? Colors.white : AppColors.hintColor,
          size: 20,
        ),
        enabledBorder: OutlineInputBorder(
          gapPadding: 0,
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color:
                (widget.isWhite == true) ? Colors.white : AppColors.hintColor,
            width: 1,
          ),
        ),
        border: OutlineInputBorder(
          gapPadding: 0,
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color:
                (widget.isWhite == true) ? Colors.white : AppColors.hintColor,
          ),
        ),
        focusColor:
            (widget.isWhite == true) ? Colors.white : AppColors.primaryText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color:
                (widget.isWhite == true) ? Colors.white : AppColors.primaryText,
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
                  isPasswordChecker! ? Icons.visibility : Icons.visibility_off,
                  color: (widget.isWhite == true)
                      ? Colors.white
                      : AppColors.hintColor,
                  size: 20,
                ),
                onPressed: () {
                  setState(() {
                    isPasswordChecker = !isPasswordChecker!;
                  });
                })
            : const SizedBox(),
      ),
    );
  }
}
