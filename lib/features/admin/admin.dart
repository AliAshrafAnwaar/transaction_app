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
    final clientProvider = ref.watch(clientProviderProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: LayoutBuilder(
            builder: (context, constraints) {
              bool isBig = constraints.maxWidth > 850;

              if (isBig) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 300),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            StlyledTextIconButton(
                              onpressed: () {
                                excelNotifier
                                    .exportClientsToExcel(clientProvider);
                              },
                              text: 'اخراج البيانات بصيغه اكسيل',
                              icon: Icons.share_outlined,
                            ),
                            Separator(),
                            StlyledTextIconButton(
                              onpressed: () {},
                              text: 'الاعدادات',
                              icon: Icons.settings,
                            ),
                            Separator(),
                            StlyledTextIconButton(
                              onpressed: () {},
                              text: 'تغيير رقم الحمايه',
                              icon: Icons.password,
                            ),
                            Separator(),
                            StlyledTextIconButton(
                              onpressed: () {
                                _showMyDialog();
                              },
                              text: 'عن التطبيق',
                              icon: Icons.info_outline,
                            ),
                            Separator(),
                            StlyledTextIconButton(
                              onpressed: () {},
                              text: 'ابدأ اليوم',
                              icon: Icons.alarm_on,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 1, // Width of the separator
                        height: 300,
                        color: Colors.grey, // Color of the separator
                        margin: EdgeInsets.symmetric(vertical: 10),
                      ),

                      // Additional settings or widgets can be added here
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: (screenWidth > 450) ? 450 : screenWidth,
                          maxHeight: screenHeight > 350 ? 350 : screenHeight,
                        ),
                        child: const Chart(),
                      ),
                      SizedBox(),
                    ],
                  ),
                );
              } else {
                return Column(
                  children: [
                    const SizedBox(height: 50),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: (screenWidth > 600) ? 600 : screenWidth,
                        maxHeight: screenHeight > 400 ? 400 : screenHeight,
                      ),
                      child: const Chart(),
                    ),
                    const SizedBox(height: 20),
                    const Separator(),
                    const SizedBox(height: 20),
                    // Additional settings or widgets can be added here
                    StlyledTextIconButton(
                      onpressed: () {
                        excelNotifier.exportClientsToExcel(clientProvider);
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
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
