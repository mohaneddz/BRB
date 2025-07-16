import 'package:flutter/material.dart';
import 'package:brb/styles/style.dart';

class MyDropdown extends StatelessWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const MyDropdown({super.key, required this.value, required this.items, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: value,
      items: items
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(e, style: const TextStyle(color: Colors.white)),
            ),
          )
          .toList(),
      onChanged: onChanged,
      dropdownColor: AppColors.darkBgLight,
      style: const TextStyle(color: Colors.white),
      iconEnabledColor: Colors.red,
      underline: Container(height: 1, color: Colors.red),
    );
  }
}
