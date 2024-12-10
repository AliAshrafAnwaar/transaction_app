import 'package:flutter/material.dart';

class ResponsiveUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Use LayoutBuilder for screen size adaptability
    return Scaffold(
      appBar: AppBar(title: Text('Responsive UI Example')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Determine the screen size
          bool isWideScreen = constraints.maxWidth > 1000;

          if (isWideScreen) {
            // For wider screens, display the container and list side by side
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 200),
                    child: SizedBox(),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (context, index) => ListTile(
                      title: Text('List Item $index'),
                    ),
                  ),
                ),
                Container(
                  width: 600, // Fixed width for the container
                  height: 400, // Fixed height for the container
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      'Container',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                ),
                Flexible(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 200),
                    child: SizedBox(),
                  ),
                ),
              ],
            );
          } else {
            // For smaller screens, display the container above the list
            return Column(
              children: [
                Container(
                  width: double.infinity, // Full width for small screens
                  height: 400,
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      'Container',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (context, index) => ListTile(
                      title: Text('List Item $index'),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
