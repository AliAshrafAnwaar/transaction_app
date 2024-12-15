import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:transaction_app/features/shared/styled_textField.dart';
import 'package:intl/intl.dart';

class StyledTextfieldDialog extends StatelessWidget {
  const StyledTextfieldDialog({
    super.key,
    required this.hint,
    required this.icon,
    required this.controller,
    this.list,
  });

  final String hint;
  final Icon icon;
  final TextEditingController controller;
  final List<String>? list;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (list != null) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                titlePadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                contentPadding: const EdgeInsets.all(10),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                title: Text(hint),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: list!.map((option) {
                    return ListTile(
                      title: Text(option),
                      onTap: () {
                        controller.text = option;
                        Navigator.pop(context);
                      },
                    );
                  }).toList(),
                ),
              );
            },
          );
        } else if (hint == 'التاريخ') {
          DateTime? dateTime = await showOmniDateTimePicker(
            context: context,
            constraints: const BoxConstraints(maxHeight: 1000, maxWidth: 500),
            is24HourMode: false, // Use 12-hour mode
            isShowSeconds: false, // Hide seconds picker
            borderRadius: BorderRadius.circular(20),
          );
          final dateFormatter =
              DateFormat('dd/MM/yy | h:ma', 'ar'); // Arabic date format

          // Use dateTime here
          if (dateTime != null) {
            final arabicDate = dateFormatter.format(dateTime);
            controller.text = dateTime.toIso8601String();
          }
        }
      },
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: AbsorbPointer(
        child: StyledTextField(
          hint: hint,
          icon: Icons.type_specimen,
          controller: controller,
          readonly: true,
        ),
      ),
    );
  }
}
