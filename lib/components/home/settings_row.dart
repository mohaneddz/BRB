import 'package:flutter/material.dart';

class MySettingRow extends StatelessWidget {
  final String label;
  final Widget child;
  final double? width;
  final String align;

  const MySettingRow({super.key, required this.label, required this.child, this.width, this.align = 'mid'});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IntrinsicWidth(
          child: Text(
            label,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
            overflow: TextOverflow.visible,
            softWrap: false,
          ),
        ),
        const Expanded(child: SizedBox()),
        SizedBox(width: width ?? 60, child: child),
      ],
    );
  }
}
