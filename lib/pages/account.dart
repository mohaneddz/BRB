import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:brb/styles/style.dart';

import 'package:brb/components/account/profile_header.dart';
import 'package:brb/components/account/info_section.dart';
import 'package:brb/components/account/info_tile.dart';
import 'package:brb/components/account/action_tile.dart';

import 'package:brb/utils/settings_utis.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  Future<void> _loadFirebaseKey() async {
    await _settingsService.init();
    setState(() {
      _firebaseKey = _settingsService.getFirebaseKey() ?? '';
      _isLoading = false;
    });
  }

  String _firebaseKey = '';
  final SettingsService _settingsService = SettingsService();
  bool _isLoading = true;
  // Mock user data - replace with actual user data
  String _username = 'mohaneddz';
  String _email = 'mohaneddz@example.com';
  String _fullName = 'Mohaned Manaa';
  String _bio = 'Flutter developer and tech enthusiast';
  String _phoneNumber = '+1 (555) 123-4567';
  final String _joinDate = 'January 2024';

  // Removed redundant redeclaration of _loadFirebaseKey

  @override
  Widget build(BuildContext context) {
    // Only load once
    if (_isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _loadFirebaseKey();
      });
      return Scaffold(
        backgroundColor: AppColors.darkBg,
        appBar: AppBar(
          backgroundColor: AppColors.darkBgLight,
          title: const Text('Account', style: TextStyle(color: Colors.white)),
          leading: IconButton(
            icon: const Icon(LucideIcons.arrowLeft, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: const Center(child: CircularProgressIndicator(color: AppColors.accent)),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        backgroundColor: AppColors.darkBgLight,
        title: const Text('Account', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.edit, color: Colors.white),
            onPressed: () => _showEditProfileDialog(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileHeader(fullName: _fullName, username: _username, bio: _bio, joinDate: _joinDate, onImagePicker: _showImagePicker),

            const SizedBox(height: 32),

            InfoSection(
              title: 'Personal Information',
              children: [
                InfoTile(icon: LucideIcons.user, title: 'Full Name', subtitle: _fullName, onTap: () => _showEditDialog('Full Name', _fullName, (value) => setState(() => _fullName = value))),
                InfoTile(icon: LucideIcons.atSign, title: 'Username', subtitle: '@$_username', onTap: () => _showEditDialog('Username', _username, (value) => setState(() => _username = value))),
                InfoTile(icon: LucideIcons.mail, title: 'Email', subtitle: _email, onTap: () => _showEditDialog('Email', _email, (value) => setState(() => _email = value))),
                InfoTile(icon: LucideIcons.phone, title: 'Phone Number', subtitle: _phoneNumber, onTap: () => _showEditDialog('Phone Number', _phoneNumber, (value) => setState(() => _phoneNumber = value))),
                InfoTile(icon: LucideIcons.fileText, title: 'Bio', subtitle: _bio, onTap: () => _showEditDialog('Bio', _bio, (value) => setState(() => _bio = value))),
                InfoTile(
                  icon: LucideIcons.key,
                  title: 'Firebase Key',
                  subtitle: _firebaseKey.isNotEmpty ? _firebaseKey : 'Not set',
                  onTap: () async {
                    final controller = TextEditingController(text: _firebaseKey);
                    String? newKey = await showDialog<String>(
                      context: context,
                      builder: (dialogContext) => AlertDialog(
                        backgroundColor: AppColors.darkBgLight,
                        title: const Text('Edit Firebase Key', style: TextStyle(color: Colors.white)),
                        content: TextField(
                          controller: controller,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: 'Enter Firebase Key',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(dialogContext),
                            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
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
                ActionTile(icon: LucideIcons.settings, title: 'Settings', subtitle: 'App preferences and configuration', onTap: _navigateToSettings),
                ActionTile(icon: LucideIcons.lock, title: 'Security', subtitle: 'Password and authentication', onTap: _navigateToSecurity),
                ActionTile(icon: LucideIcons.shield, title: 'Privacy', subtitle: 'Privacy and data settings', onTap: _navigateToPrivacy),
              ],
            ),

            const SizedBox(height: 32),

            InfoSection(
              title: 'Support & Info',
              children: [
                ActionTile(icon: LucideIcons.helpCircle, title: 'Help Center', subtitle: 'Get help and support', onTap: _showHelpCenter),
                ActionTile(icon: LucideIcons.messageSquare, title: 'Send Feedback', subtitle: 'Share your thoughts with us', onTap: _showFeedbackDialog),
                ActionTile(icon: LucideIcons.info, title: 'About', subtitle: 'App version and information', onTap: _showAboutDialog),
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
        backgroundColor: AppColors.darkBgLight,
        title: const Text('Edit Profile', style: TextStyle(color: Colors.white)),
        content: const Text('Full profile editing functionality would go here.', style: TextStyle(color: Colors.grey)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
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
        backgroundColor: AppColors.darkBgLight,
        title: Text('Edit $field', style: const TextStyle(color: Colors.white)),
        content: TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Enter $field',
            hintStyle: const TextStyle(color: Colors.grey),
            enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.redAccent)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
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

  void _showImagePicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.darkBgLight,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Change Profile Picture',
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [_buildImagePickerOption(LucideIcons.camera, 'Camera', () {}), _buildImagePickerOption(LucideIcons.image, 'Gallery', () {}), _buildImagePickerOption(LucideIcons.trash2, 'Remove', () {})],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePickerOption(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(color: Colors.redAccent.withAlpha(1), shape: BoxShape.circle),
            child: Icon(icon, color: Colors.redAccent, size: 24),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 14)),
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
        backgroundColor: AppColors.darkBgLight,
        title: const Text('Help Center', style: TextStyle(color: Colors.white)),
        content: const Text('Help center content would go here.', style: TextStyle(color: Colors.grey)),
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
        backgroundColor: AppColors.darkBgLight,
        title: const Text('Send Feedback', style: TextStyle(color: Colors.white)),
        content: const TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Enter your feedback...',
            hintStyle: TextStyle(color: Colors.grey),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.redAccent)),
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
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
        backgroundColor: AppColors.darkBgLight,
        title: const Text('About', style: TextStyle(color: Colors.white)),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('App Version: 1.0.0', style: TextStyle(color: Colors.grey)),
            Text('Build: 100', style: TextStyle(color: Colors.grey)),
            Text('© 2024 Your Company', style: TextStyle(color: Colors.grey)),
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
        backgroundColor: AppColors.darkBgLight,
        title: const Text('Logout', style: TextStyle(color: Colors.white)),
        content: const Text('Are you sure you want to logout?', style: TextStyle(color: Colors.grey)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
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
