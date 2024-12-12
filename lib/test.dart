import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo or App Name
            Text(
              'MyApp',
              style: TextStyle(color: Colors.white),
            ),

            // Navigation Links
            Row(
              children: [
                TextButton(
                  onPressed: () {}, // Navigate to Home
                  child: Text(
                    'Home',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () {}, // Navigate to Features
                  child: Text(
                    'Features',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () {}, // Navigate to About
                  child: Text(
                    'About',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () {}, // Navigate to Contact
                  child: Text(
                    'Contact',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text('Welcome to MyApp!'),
      ),
    );
  }
}
