import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:brb/styles/style.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CustomPinSection extends StatelessWidget {
  final bool enabled;
  final TextEditingController pinController;
  final bool obscurePin;
  final ValueChanged<bool> onToggle;
  final VoidCallback onToggleObscure;

  const CustomPinSection({super.key, required this.enabled, required this.pinController, required this.obscurePin, required this.onToggle, required this.onToggleObscure, required Future<Null> Function(dynamic pin) onPinChanged});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.darkBgLight,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Custom PIN',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Switch(value: enabled, onChanged: onToggle, activeColor: AppColors.accent),
              ],
            ),
            if (enabled) ...[
              const SizedBox(height: 16),
              TextFormField(
                controller: pinController,
                obscureText: obscurePin,
                keyboardType: TextInputType.number,
                maxLength: 6,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Enter 4-6 digit PIN',
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: AppColors.darkBg,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                  suffixIcon: IconButton(
                    icon: Icon(obscurePin ? LucideIcons.eye : LucideIcons.eyeOff, color: Colors.grey),
                    onPressed: onToggleObscure,
                  ),
                ),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
