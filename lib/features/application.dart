import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transaction_app/core/app_colors.dart';
import 'package:transaction_app/features/admin/admin.dart';
import 'package:transaction_app/features/shared/styled_textField.dart';
import 'package:transaction_app/features/transaction/all_transactions.dart';
import 'package:transaction_app/features/client/clients_screen.dart';
import 'package:transaction_app/features/home/home.dart';
import 'package:transaction_app/providers/client_provider.dart';

class Application extends ConsumerStatefulWidget {
  const Application({super.key});

  @override
  ApplicationState createState() => ApplicationState();
}

class ApplicationState extends ConsumerState<Application> {
  int _selectedIndex = 0;
  String title = 'المنزل | تسجيل عمليه';

  TextEditingController searchController = TextEditingController();

  // List of pages to display for each bottom navigation item
  final List<Widget> _pages = [
    const Home(),
    const AllTransactions(),
    const ClientsScreen(),
    AdminPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      searchController.text = '';
      _selectedIndex = index; // Update the selected index
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWeb = constraints.maxWidth > 1200;

        if (isWeb) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo or App Name
                  Text(
                    title,
                    style: const TextStyle(color: Colors.white),
                  ),
                  (_selectedIndex == 1 || _selectedIndex == 2)
                      ? Expanded(
                          child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: StyledTextField(
                            controller: searchController,
                            hint: 'بحث عن',
                            icon: Icons.search,
                            isNotifier: true,
                            isWhite: true,
                          ),
                        ))
                      : SizedBox(),
                  Expanded(child: SizedBox()),
                  // Navigation Links
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          title = 'المنزل | تسجيل العمليه';
                          _onItemTapped(0);
                        }, // Navigate to Home
                        child: const Text(
                          'المنزل',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          title = 'العمليات';
                          _onItemTapped(1);
                        }, // Navigate to Features
                        child: const Text(
                          'العمليات',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          title = 'العملاء';
                          _onItemTapped(2);
                        }, // Navigate to About
                        child: const Text(
                          'العملاء',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          title = 'الاعدادات';
                          _onItemTapped(3);
                        }, // Navigate to Contact
                        child: const Text(
                          'الاعدادات',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            body: _pages[_selectedIndex], // Display the selected page
          );
        } else {
          return Scaffold(
            body: _pages[_selectedIndex], // Display the selected page
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Colors.blue,
              unselectedItemColor: AppColors.hintColor,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'المنزل',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  label: 'المعاملات',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'العملاء',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.admin_panel_settings),
                  label: 'الاعدادات',
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTapped, // Handle tap
            ),
          );
        }
      },
    );
  }
}
