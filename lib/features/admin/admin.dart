import 'package:flutter/material.dart';
import 'package:transaction_app/features/admin/chart.dart';
import 'package:transaction_app/features/admin/separator.dart';
import 'package:transaction_app/features/admin/stlyled_text_icon_button.dart';

class AdminPage extends StatefulWidget {
  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  late double screenWidth;
  late double screenHeight;

  @override
  Widget build(BuildContext context) {
    // Get screen size dynamically
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = screenWidth * 0.5; // Adjust height based on width

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(width: 16, height: 16, color: Colors.blue),
                      const SizedBox(width: 8),
                      const Text(
                        'ايداع',
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Row(
                    children: [
                      Container(width: 16, height: 16, color: Colors.purple),
                      const SizedBox(width: 8),
                      const Text(
                        'سحب',
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: (screenWidth > 1000) ? 1000 : screenWidth,
                  maxHeight: screenHeight > 500 ? 500 : screenHeight,
                ),
                child: const Chart(),
              ),
              const SizedBox(height: 20),
              const Separator(),
              const SizedBox(height: 20),
              // Additional settings or widgets can be added here
              const StlyledTextIconButton(
                text: 'اخراج البيانات بصيغه اكسيل',
                icon: Icons.share_outlined,
              ),
              const Separator(),
              const StlyledTextIconButton(
                text: 'الاعدادات',
                icon: Icons.settings,
              ),
              const Separator(),
              const StlyledTextIconButton(
                text: 'تغيير رقم الحمايه',
                icon: Icons.password,
              ),
              const Separator(),
              const StlyledTextIconButton(
                text: 'عن التطبيق',
                icon: Icons.info_outline,
              ),
              const Separator(),
            ],
          ),
        ),
      ),
    );
  }
}
