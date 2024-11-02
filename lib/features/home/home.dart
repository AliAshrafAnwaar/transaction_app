import 'package:flutter/material.dart';
import 'package:transaction_app/features/display/display.dart';
import 'package:transaction_app/features/home/application.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // List of pages to display for each bottom navigation item
  final List<Widget> _pages = [
    Application(),
    Display(),
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

// Admin Page Widget
class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Admin Page', style: TextStyle(fontSize: 24)),
    );
  }
}
