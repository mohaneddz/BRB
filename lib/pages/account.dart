import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:brb/styles/style.dart';

import 'package:brb/components/account/profile_header.dart';
import 'package:brb/components/account/info_section.dart';
import 'package:brb/components/account/info_tile.dart';
import 'package:brb/components/account/action_tile.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:brb/pages/settings.dart';
import 'package:brb/utils/settings_utis.dart';
import 'package:brb/utils/theme_controller.dart';
import 'package:brb/utils/locale_controller.dart';
import 'package:brb/l10n/app_localizations.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  Future<void> _loadProfile() async {
    await _settingsService.init();
    setState(() {
      _firebaseKey = _settingsService.getFirebaseKey() ?? '';
      _fullName = _settingsService.getFullName();
      _username = _settingsService.getUsername();
      _email = _settingsService.getEmail();
      _phoneNumber = _settingsService.getPhoneNumber();
      _bio = _settingsService.getBio();
      _isLoading = false;
    });
  }

  String _firebaseKey = '';
  final SettingsService _settingsService = SettingsService();
  bool _isLoading = true;
  String _username = 'mohaneddz';
  String _email = 'mohaneddz@example.com';
  String _fullName = 'Mohaned Manaa';
  String _bio = 'Flutter developer and tech enthusiast';
  String _phoneNumber = '+1 (555) 123-4567';
  final String _joinDate = 'January 2024';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // Only load once
    if (_isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _loadProfile();
      });
      return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.navAccount),
          leading: IconButton(
            icon: const Icon(LucideIcons.arrowLeft),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: const Center(child: CircularProgressIndicator(color: AppColors.accent)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.navAccount),
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileHeader(fullName: _fullName, username: _username, bio: _bio, joinDate: _joinDate),

            const SizedBox(height: 32),

            InfoSection(
              title: l10n.accountPersonalInfo,
              children: [
                ProfileInfoTile(
                  icon: LucideIcons.user,
                  title: l10n.accountFullName,
                  subtitle: _fullName,
                  onTap: () => _showEditDialog(l10n.accountFullName, _fullName, (value) async {
                    setState(() => _fullName = value);
                    await _settingsService.setFullName(value);
                  }),
                ),
                ProfileInfoTile(
                  icon: LucideIcons.atSign,
                  title: l10n.accountUsername,
                  subtitle: '@$_username',
                  onTap: () => _showEditDialog(l10n.accountUsername, _username, (value) async {
                    setState(() => _username = value);
                    await _settingsService.setUsername(value);
                  }),
                ),
                ProfileInfoTile(
                  icon: LucideIcons.mail,
                  title: l10n.accountEmail,
                  subtitle: _email,
                  onTap: () => _showEditDialog(l10n.accountEmail, _email, (value) async {
                    setState(() => _email = value);
                    await _settingsService.setEmail(value);
                  }),
                ),
                ProfileInfoTile(
                  icon: LucideIcons.phone,
                  title: l10n.accountPhoneNumber,
                  subtitle: _phoneNumber,
                  onTap: () => _showEditDialog(l10n.accountPhoneNumber, _phoneNumber, (value) async {
                    setState(() => _phoneNumber = value);
                    await _settingsService.setPhoneNumber(value);
                  }),
                ),
                ProfileInfoTile(
                  icon: LucideIcons.fileText,
                  title: l10n.accountBio,
                  subtitle: _bio,
                  onTap: () => _showEditDialog(l10n.accountBio, _bio, (value) async {
                    setState(() => _bio = value);
                    await _settingsService.setBio(value);
                  }),
                ),
                ProfileInfoTile(
                  icon: LucideIcons.key,
                  title: l10n.accountFirebaseKey,
                  subtitle: _firebaseKey.isNotEmpty ? _firebaseKey : l10n.accountNotSet,
                  onTap: () async {
                    final controller = TextEditingController(text: _firebaseKey);
                    String? newKey = await showDialog<String>(
                      context: context,
                      builder: (dialogContext) => AlertDialog(
                        title: Text('${l10n.dialogEditPrefix} ${l10n.accountFirebaseKey}'),
                        content: TextField(
                          controller: controller,
                          decoration: InputDecoration(hintText: '${l10n.dialogEnterPrefix} ${l10n.accountFirebaseKey}'),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(dialogContext),
                            child: Text(l10n.dialogCancel, style: TextStyle(color: AppColors.secondaryText(dialogContext))),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(dialogContext, controller.text);
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent, foregroundColor: Colors.white),
                            child: Text(l10n.buttonSave),
                          ),
                        ],
                      ),
                    );
                    if (newKey != null) {
                      setState(() => _firebaseKey = newKey);
                      await _settingsService.setFirebaseKey(newKey);
                    }
                  },
                ),
              ],
            ),

            const SizedBox(height: 32),

            InfoSection(
              title: l10n.accountQuickActions,
              children: [
                ProfileActionTile(
                  icon: LucideIcons.settings,
                  title: l10n.navSettings,
                  subtitle: l10n.accountSettingsSubtitle,
                  onTap: _openSettings,
                ),
                ProfileActionTile(
                  icon: LucideIcons.lock,
                  title: l10n.settingsSectionSecurity,
                  subtitle: l10n.accountSecuritySubtitle,
                  onTap: _openSettings,
                ),
              ],
            ),

            const SizedBox(height: 40),

            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: ElevatedButton.icon(
                onPressed: _showResetDialog,
                icon: const Icon(LucideIcons.trash2, size: 20),
                label: Text(l10n.accountResetAppData, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(String field, String currentValue, Function(String) onSave) {
    final l10n = AppLocalizations.of(context)!;
    final controller = TextEditingController(text: currentValue);
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('${l10n.dialogEditPrefix} $field'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: '${l10n.dialogEnterPrefix} $field'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.dialogCancel, style: TextStyle(color: AppColors.secondaryText(dialogContext))),
          ),
          TextButton(
            onPressed: () {
              onSave(controller.text);
              Navigator.pop(dialogContext);
            },
            child: Text(l10n.buttonSave, style: const TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }

  void _openSettings() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const Settings()),
    );
  }

  /// Wipes every persisted value - presets, history, profile fields and all
  /// settings - back to first-launch defaults. There's no account system to
  /// log out of, so this is what the destructive action on this screen does.
  void _showResetDialog() {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.accountResetAppData),
        content: Text(l10n.accountResetDialogBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.dialogCancel, style: TextStyle(color: AppColors.secondaryText(dialogContext))),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              if (!mounted) return;
              setState(() => _isLoading = true);
              themeModeNotifier.value = ThemeMode.dark;
              localeNotifier.value = const Locale('en');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.accountResetSnackbar)),
              );
            },
            child: Text(l10n.dialogReset, style: const TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }
}
