import 'package:flutter/material.dart';

class MySettingRow extends StatelessWidget {
  final String label;
  final Widget child;
  final double? width;

  const MySettingRow({super.key, required this.label, required this.child, this.width});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: width ?? 90,
          child: Text(
            label,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(child: child),
      ],
    );
  }
}
