import 'package:flutter/material.dart';
import 'package:transaction_app/core/app_colors.dart';
import 'package:transaction_app/features/admin/admin.dart';
import 'package:transaction_app/features/transaction/all_transactions.dart';
import 'package:transaction_app/features/client/clients_screen.dart';
import 'package:transaction_app/features/home/home.dart';

class Application extends StatefulWidget {
  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  int _selectedIndex = 0;

  // List of pages to display for each bottom navigation item
  final List<Widget> _pages = [
    const Home(),
    const AllTransactions(),
    const ClientsScreen(),
    AdminPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color.fromARGB(255, 103, 80, 164),
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
}
