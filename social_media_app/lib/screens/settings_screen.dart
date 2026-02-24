import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Settings', style: TextStyle(fontWeight: FontWeight.w700)),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          _buildSectionHeader('Account'),
          _buildSettingItem(Icons.person_outline, 'Personal Information'),
          _buildSettingItem(Icons.bookmark_border, 'Saved'),
          const Divider(color: Colors.white10, height: 32),

          _buildSectionHeader('Settings'),
          _buildSettingItem(Icons.notifications_none, 'Notifications'),
          _buildSettingItem(Icons.lock_outline, 'Privacy'),
          _buildSettingItem(Icons.security, 'Security'),
          _buildSettingItem(Icons.palette_outlined, 'Theme'),
          const Divider(color: Colors.white10, height: 32),

          _buildSectionHeader('Login'),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.redAccent, size: 28),
            title: const Text('Log Out', style: TextStyle(color: Colors.redAccent, fontSize: 16)),
            onTap: () {},
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 10, top: 10),
      child: Text(
        title,
        style: const TextStyle(color: Colors.white54, fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSettingItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.white, size: 28),
      title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 16)),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white54, size: 16),
      onTap: () {},
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }
}