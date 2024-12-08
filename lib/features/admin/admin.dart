import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transaction_app/features/admin/chart.dart';
import 'package:transaction_app/features/admin/separator.dart';
import 'package:transaction_app/features/admin/stlyled_text_icon_button.dart';
import 'package:transaction_app/providers/client_provider.dart';
import 'package:transaction_app/providers/excel_provider.dart';

class AdminPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends ConsumerState<AdminPage> {
  late double screenWidth;
  late double screenHeight;

  Future<String?> _showMyDialog() async {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('ترنزاوي'),
        content: const Text(
            "تطبيق ترنزاوي هو تطبيق يساعد المستخدمين على إدارة وتتبع معاملاتهم المالية بسهولة. يتيح التطبيق إمكانية تصنيف المعاملات، البحث عنها، وترتيبها بناءً على التاريخ أو المبلغ أو النوع. يتميز التطبيق بواجهة مستخدم بسيطة وسهلة الاستخدام، مع دعم للغة العربية لتوفير تجربة سلسة للمستخدمين. كما يدعم التطبيق ميزات إضافية مثل تحليل البيانات المالية وعرض تقارير مفصلة لتحسين إدارة الأموال."),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text(
              'حسنا',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size dynamically
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = screenWidth * 0.5; // Adjust height based on width

    final excelNotifier = ref.read(excelProviderProvider.notifier);
    final ClientProvider = ref.watch(clientProviderProvider);

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
              StlyledTextIconButton(
                onpressed: () {
                  excelNotifier.exportClientsToExcel(ClientProvider);
                },
                text: 'اخراج البيانات بصيغه اكسيل',
                icon: Icons.share_outlined,
              ),
              const Separator(),
              StlyledTextIconButton(
                onpressed: () {},
                text: 'الاعدادات',
                icon: Icons.settings,
              ),
              const Separator(),
              StlyledTextIconButton(
                onpressed: () {},
                text: 'تغيير رقم الحمايه',
                icon: Icons.password,
              ),
              const Separator(),
              StlyledTextIconButton(
                onpressed: () {
                  _showMyDialog();
                },
                text: 'عن التطبيق',
                icon: Icons.info_outline,
              ),
              const Separator(),
              StlyledTextIconButton(
                onpressed: () {},
                text: 'ابدأ اليوم',
                icon: Icons.alarm_on,
              ),
              const Separator(),
            ],
          ),
        ),
      ),
    );
  }
}
