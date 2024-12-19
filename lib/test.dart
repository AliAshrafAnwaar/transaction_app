import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DragToSyncPage(),
    );
  }
}

class DragToSyncPage extends StatefulWidget {
  @override
  _DragToSyncPageState createState() => _DragToSyncPageState();
}

class _DragToSyncPageState extends State<DragToSyncPage> {
  final List<String> _items = List.generate(20, (index) => 'Item $index');

  Future<void> _refreshData() async {
    // Simulate a network request or data reload
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _items.insert(0, 'New Item ${_items.length + 1}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drag to Sync Example'),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: ListView.builder(
          itemCount: _items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_items[index]),
            );
          },
        ),
      ),
    );
  }
}
