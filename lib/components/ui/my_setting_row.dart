import 'package:flutter/material.dart';

class MySettingRow extends StatelessWidget {
  final String label;
  final Widget child;
  final double? width;
  final IconData? icon; // Add this line

  const MySettingRow({
    super.key,
    required this.label,
    required this.child,
    this.width,
    this.icon, // Add this line
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null)
          Padding(
            padding: const EdgeInsets.only(right: 6.0),
            child: Icon(icon, color: Colors.red, size: 16),
          ),
        SizedBox(
          width: width ?? 90,
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(child: child),
      ],
    );
  }
}
