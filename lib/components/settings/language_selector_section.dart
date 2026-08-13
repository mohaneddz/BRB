import 'package:flutter/material.dart';
import 'package:brb/styles/style.dart';
import 'package:lucide_icons/lucide_icons.dart';

class LanguageSelectorSection extends StatelessWidget {
  final String selectedLanguage;
  final List<String> languages;
  final ValueChanged<String?> onChanged;

  const LanguageSelectorSection({super.key, required this.selectedLanguage, required this.languages, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Language',
              style: TextStyle(color: AppColors.primaryText(context), fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: selectedLanguage,
              dropdownColor: AppColors.background(context),
              style: TextStyle(color: AppColors.primaryText(context)),
              icon: const SizedBox.shrink(),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.background(context),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                prefixIcon: Icon(LucideIcons.globe, color: AppColors.primaryText(context)),
              ),
              items: languages.map((language) {
                return DropdownMenuItem(
                  value: language,
                  child: Row(children: [const SizedBox(width: 8), Text(language)]),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
