import 'package:flutter/material.dart';
import 'package:transaction_app/features/admin/chart.dart';

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
                child: Chart(),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 1, // Thickness
                width: double.infinity, // Full width
                child: Padding(
                  padding: const EdgeInsets.only(left: 100, right: 100),
                  child: DecoratedBox(
                    decoration:
                        BoxDecoration(color: Colors.grey.withOpacity(0.5)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Additional settings or widgets can be added here
            ],
          ),
        ),
      ),
    );
  }
}
