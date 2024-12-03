import 'package:flutter/material.dart';
import 'package:transaction_app/core/app_colors.dart';

class StlyledTextIconButton extends StatelessWidget {
  const StlyledTextIconButton(
      {super.key,
      required this.text,
      required this.icon,
      required this.onpressed});

  final String text;
  final IconData icon;
  final Function onpressed;

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> isPressed = ValueNotifier<bool>(false);
    return GestureDetector(
      onTapDown: (_) => isPressed.value = true, // Apply filter on press
      onTapUp: (_) {
        isPressed.value = false; // Remove filter on release
      },
      onHorizontalDragDown: (details) => isPressed.value = true,
      onHorizontalDragEnd: (details) => isPressed.value = false,
      onTap: () {
        onpressed();
      },
      child: ValueListenableBuilder(
        valueListenable: isPressed,
        builder: (context, value, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            decoration: BoxDecoration(
              color: value
                  ? Colors.grey.withOpacity(0.3)
                  : Colors.transparent, // Overlay color
              borderRadius: BorderRadius.circular(8), // Optional: Rounded edges
              gradient: LinearGradient(colors: [
                Colors.grey.withOpacity(0.1),
                Colors.grey.withOpacity(0.5),
                Colors.grey.withOpacity(0.1),
              ], begin: Alignment.centerLeft, end: Alignment.centerRight),
            ),
            child: child,
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Icon(icon, color: Colors.blue),
              const SizedBox(
                width: 20,
              ),
              Text(
                text,
                style: const TextStyle(color: AppColors.primaryText),
              ),
              const Expanded(child: const SizedBox()),
              Icon(Icons.arrow_forward_ios, color: Colors.grey)
            ],
          ),
        ),
      ),
    );
  }
}
