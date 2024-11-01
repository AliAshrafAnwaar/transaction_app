import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:transaction_app/features/shared/styled_button.dart';
import 'package:transaction_app/features/shared/styled_textField.dart';

void main() {
  runApp(const Directionality(
      textDirection: TextDirection.rtl,
      child: MaterialApp(
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          supportedLocales: [Locale('ar', 'AE')],
          home: Application())));
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تسجيل عمليه السحب"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const StyledTextField(hint: "الاسم", icon: Icons.person),
            const StyledTextField(hint: "رقم الهاتف", icon: Icons.phone),
            const StyledTextField(hint: "المبلغ", icon: Icons.money),
            const StyledTextField(
                hint: "نوع العمليه", icon: Icons.type_specimen),
            const StyledTextField(hint: "تاريخ العمليه", icon: Icons.timelapse),
            const StyledTextField(hint: "طريقه الدفع", icon: Icons.directions),
            const SizedBox(height: 30),
            StyledButton(onPressed: () {}, text: "تسجيل العمليه")
          ],
        ),
      ),
    );
  }
}
