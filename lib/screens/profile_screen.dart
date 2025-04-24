import 'package:experiment/extentions.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Profile Settings', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Profile Header
            Row(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage("assets/images/people/deb.png") // Replace
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Owhonda Deborah',
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'albertstevano@gmail.com',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),
            // Profile Section
            const Text(
              'Profile',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildListTile(
              title: 'Personal Data',
              icon: Icons.person_outline,
              onTap: () {
                // Handle Personal Data
              },
            ),
            _buildListTile(
              title: 'Settings',
              icon: Icons.settings,
              onTap: () {
                // Handle Settings
              },
            ),
            _buildListTile(
              title: 'Extra Card',
              icon: Icons.credit_card_outlined,
              onTap: () {
                // Handle Extra Card
              },
            ),
            const SizedBox(height: 24),
            // Support Section
            const Text(
              'Support',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildListTile(
              title: 'Help Center',
              icon: Icons.help_outline,
              onTap: () {
                // Handle Help Center
              },
            ),
            _buildListTile(
              title: 'Request Account Deletion',
              icon: Icons.delete_outline,
              onTap: () {
                // Handle Account Deletion
              },
            ),
            _buildListTile(
              title: 'Add another account',
              icon: Icons.person_add_outlined,
              onTap: () {
                // Handle Add Account
              },
            ),
            const SizedBox(height: 32),
            // Sign Out Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => AuthScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.logout, color: Colors.white),
                    const SizedBox(width: 8),
                    const Text('Sign Out', style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildListTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[600]),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      trailing: const Icon(Icons.arrow_forward_ios,
          color: Colors.grey), // Use iOS style arrow
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
    );
  }
}

