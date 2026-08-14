import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:brb/styles/style.dart';

import 'package:brb/components/account/profile_header.dart';
import 'package:brb/components/account/info_section.dart';
import 'package:brb/components/account/info_tile.dart';
import 'package:brb/components/account/action_tile.dart';

import 'package:brb/utils/settings_utis.dart';
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
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.edit),
            onPressed: () => _showEditProfileDialog(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileHeader(fullName: _fullName, username: _username, bio: _bio, joinDate: _joinDate),

            const SizedBox(height: 32),

            InfoSection(
              title: 'Personal Information',
              children: [
                ProfileInfoTile(
                  icon: LucideIcons.user,
                  title: 'Full Name',
                  subtitle: _fullName,
                  onTap: () => _showEditDialog('Full Name', _fullName, (value) async {
                    setState(() => _fullName = value);
                    await _settingsService.setFullName(value);
                  }),
                ),
                ProfileInfoTile(
                  icon: LucideIcons.atSign,
                  title: 'Username',
                  subtitle: '@$_username',
                  onTap: () => _showEditDialog('Username', _username, (value) async {
                    setState(() => _username = value);
                    await _settingsService.setUsername(value);
                  }),
                ),
                ProfileInfoTile(
                  icon: LucideIcons.mail,
                  title: 'Email',
                  subtitle: _email,
                  onTap: () => _showEditDialog('Email', _email, (value) async {
                    setState(() => _email = value);
                    await _settingsService.setEmail(value);
                  }),
                ),
                ProfileInfoTile(
                  icon: LucideIcons.phone,
                  title: 'Phone Number',
                  subtitle: _phoneNumber,
                  onTap: () => _showEditDialog('Phone Number', _phoneNumber, (value) async {
                    setState(() => _phoneNumber = value);
                    await _settingsService.setPhoneNumber(value);
                  }),
                ),
                ProfileInfoTile(
                  icon: LucideIcons.fileText,
                  title: 'Bio',
                  subtitle: _bio,
                  onTap: () => _showEditDialog('Bio', _bio, (value) async {
                    setState(() => _bio = value);
                    await _settingsService.setBio(value);
                  }),
                ),
                ProfileInfoTile(
                  icon: LucideIcons.key,
                  title: 'Firebase Key',
                  subtitle: _firebaseKey.isNotEmpty ? _firebaseKey : 'Not set',
                  onTap: () async {
                    final controller = TextEditingController(text: _firebaseKey);
                    String? newKey = await showDialog<String>(
                      context: context,
                      builder: (dialogContext) => AlertDialog(
                        title: const Text('Edit Firebase Key'),
                        content: TextField(
                          controller: controller,
                          decoration: const InputDecoration(hintText: 'Enter Firebase Key'),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(dialogContext),
                            child: Text('Cancel', style: TextStyle(color: AppColors.secondaryText(dialogContext))),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(dialogContext, controller.text);
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent, foregroundColor: Colors.white),
                            child: const Text('Save'),
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
              title: 'Quick Actions',
              children: [
                ProfileActionTile(icon: LucideIcons.settings, title: 'Settings', subtitle: 'App preferences and configuration', onTap: _navigateToSettings),
                ProfileActionTile(icon: LucideIcons.lock, title: 'Security', subtitle: 'Password and authentication', onTap: _navigateToSecurity),
                ProfileActionTile(icon: LucideIcons.shield, title: 'Privacy', subtitle: 'Privacy and data settings', onTap: _navigateToPrivacy),
              ],
            ),

            const SizedBox(height: 32),

            InfoSection(
              title: 'Support & Info',
              children: [
                ProfileActionTile(icon: LucideIcons.helpCircle, title: 'Help Center', subtitle: 'Get help and support', onTap: _showHelpCenter),
                ProfileActionTile(icon: LucideIcons.messageSquare, title: 'Send Feedback', subtitle: 'Share your thoughts with us', onTap: _showFeedbackDialog),
                ProfileActionTile(icon: LucideIcons.info, title: 'About', subtitle: 'App version and information', onTap: _showAboutDialog),
              ],
            ),

            const SizedBox(height: 40),

            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: ElevatedButton.icon(
                onPressed: _showLogoutDialog,
                icon: const Icon(LucideIcons.logOut, size: 20),
                label: const Text('Logout', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
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

  void _showEditProfileDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: const Text('Full profile editing functionality would go here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: AppColors.secondaryText(context))),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Save', style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(String field, String currentValue, Function(String) onSave) {
    final controller = TextEditingController(text: currentValue);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit $field'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: 'Enter $field'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: AppColors.secondaryText(context))),
          ),
          TextButton(
            onPressed: () {
              onSave(controller.text);
              Navigator.pop(context);
            },
            child: const Text('Save', style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }

  void _navigateToSettings() {
    // Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Navigate to Settings page')));
  }

  void _navigateToSecurity() {
    // Navigator.push(context, MaterialPageRoute(builder: (context) => SecurityPage()));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Navigate to Security page')));
  }

  void _navigateToPrivacy() {
    // Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyPage()));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Navigate to Privacy page')));
  }

  void _showHelpCenter() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Help Center'),
        content: const Text('Help center content would go here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }

  void _showFeedbackDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Send Feedback'),
        content: const TextField(
          decoration: InputDecoration(hintText: 'Enter your feedback...'),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: AppColors.secondaryText(context))),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Send', style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('App Version: 1.0.0'),
            Text('Build: 100'),
            Text('© 2024 Your Company'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: AppColors.secondaryText(context))),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Add logout logic here
            },
            child: const Text('Logout', style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }
}
