import 'package:flutter/material.dart';
import 'package:brb/styles/style.dart'; // Assuming AppColors is defined here
import 'package:lucide_icons/lucide_icons.dart';

class MyDropdown extends StatelessWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const MyDropdown({super.key, required this.value, required this.items, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red, width: 1.0),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          items: items
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    e,
                    style: TextStyle(color: AppColors.primaryText(context), fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
          underline: const SizedBox(),
          dropdownColor: AppColors.dropdownSurface(context),
          // give it shadow
          style: TextStyle(color: AppColors.primaryText(context)),
          iconEnabledColor: Colors.red,
          icon: const Icon(LucideIcons.chevronDown, color: Colors.red, size: 20),
          itemHeight: 48, // Must be >= 48
        ),
      ),
    );
  }
}
