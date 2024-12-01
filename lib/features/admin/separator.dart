import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  const Separator({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1, // Thickness
      width: double.infinity, // Full width
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: DecoratedBox(
          decoration: BoxDecoration(color: Colors.grey.withOpacity(0.5)),
        ),
      ),
    );
  }
}
