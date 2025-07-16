import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AddPresetButton extends StatelessWidget {
  final VoidCallback onPressed;
  const AddPresetButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.red,
      onPressed: onPressed,
      child: const Icon(LucideIcons.plus, color: Colors.white),
    );
  }
}
