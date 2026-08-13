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
  final ValueChanged<String> onPinChanged;

  const CustomPinSection({
    super.key,
    required this.enabled,
    required this.pinController,
    required this.obscurePin,
    required this.onToggle,
    required this.onToggleObscure,
    required this.onPinChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Custom PIN',
                  style: TextStyle(color: AppColors.primaryText(context), fontSize: 16, fontWeight: FontWeight.w500),
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
                style: TextStyle(color: AppColors.primaryText(context)),
                decoration: InputDecoration(
                  hintText: 'Enter 4-6 digit PIN',
                  hintStyle: TextStyle(color: AppColors.secondaryText(context)),
                  filled: true,
                  fillColor: AppColors.background(context),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                  suffixIcon: IconButton(
                    icon: Icon(obscurePin ? LucideIcons.eye : LucideIcons.eyeOff, color: AppColors.secondaryText(context)),
                    onPressed: onToggleObscure,
                  ),
                ),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: onPinChanged,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
