import 'package:experiment/extentions.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  String? _username;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Function to load user data
  Future<void> _loadUserData() async {
    _user = _auth.currentUser;
    if (_user != null) {
      // Get username from display name
      _username = _user!.displayName;
      setState(() {}); // Trigger a rebuild to display the data
    }
  }

  // Function to obscure email
  String _obscureEmail(String email) {
    if (email.isEmpty) return "";
    List<String> parts = email.split('@');
    if (parts.length != 2) return email; // Invalid email format

    String username = parts[0];
    String domain = parts[1];
    if (username.length <= 3) return email;
    String obscuredUsername =
        username.substring(0, 3) +
            '*' * (username.length - 3); //show first 3 letters only
    return '$obscuredUsername@$domain';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Use a light background
      appBar: AppBar(
        automaticallyImplyLeading:
        false, // Remove the back arrow, handled in sign out.
        title: const Text('Profile',
            style: TextStyle(
                color: Colors.black,
                fontWeight:
                FontWeight.bold)), // Bold title, consistent color
        backgroundColor: Colors.transparent,
        elevation: 0, // Remove shadow for a cleaner look
        iconTheme: const IconThemeData(
            color:
            Colors.black), // Ensure icons are also black if used later
      ),
      body: Padding(
        padding: const EdgeInsets.all(20), // Increased padding
        child: ListView(
          children: <Widget>[
            // Profile Header
            Container(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16), // Added padding to the container
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                        12), // Rounded corners for the container
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 2),
                        blurRadius: 8,
                        color: Colors.grey.withOpacity(
                            0.2), // Subtle shadow for depth
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Padding(
                        padding:
                        EdgeInsets.only(left: 16.0), // Padding for the avatar
                        child: CircleAvatar(
                          radius:
                          40, // Increased radius for a larger avatar.
                          backgroundImage:
                          AssetImage("assets/images/people/deb.png"), // Replace
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _username ??
                                'Loading...', // Show "Loading" if username is null
                            style: const TextStyle(
                                fontSize: 20,
                                overflow: TextOverflow.fade,
                                fontWeight: FontWeight
                                    .w600), // Increased font size and weight
                          ),
                          Text(
                            _user?.email != null
                                ? _obscureEmail(_user!.email!)
                                : 'No Email', // Show obscured email or "No Email"
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors
                                    .grey[600]), // Use the grey color from your design
                          ),
                        ],
                      ),
                    ],
                  ),
                ),]
              ),
            ),
            const SizedBox(height: 32),
            // Profile Section
            const Text(
              'Profile',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold), // Increased font size
            ),
            const SizedBox(height: 12), // Increased spacing
            _buildListTile(
              title: 'Personal Data',
              icon: Icons.person_outline,
              onTap: () {
                // Handle Personal Data
                _showFeatureNotImplementedDialog(context);
              },
            ),
            _buildListTile(
              title: 'Settings',
              icon: Icons.settings,
              onTap: () {
                // Handle Settings
                _showFeatureNotImplementedDialog(context);
              },
            ),
            _buildListTile(
              title: 'Extra Card',
              icon: Icons.credit_card_outlined,
              onTap: () {
                // Handle Extra Card
                _showFeatureNotImplementedDialog(context);
              },
            ),
            const SizedBox(height: 24),
            // Support Section
            const Text(
              'Support',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold), // Increased font size
            ),
            const SizedBox(height: 12), // Increased spacing
            _buildListTile(
              title: 'Help Center',
              icon: Icons.help_outline,
              onTap: () {
                // Handle Help Center
                _showFeatureNotImplementedDialog(context);
              },
            ),
            _buildListTile(
              title: 'Request Account Deletion',
              icon: Icons.delete_outline,
              onTap: () {
                // Handle Account Deletion
                _showFeatureNotImplementedDialog(context);
              },
            ),
            _buildListTile(
              title: 'Add another account',
              icon: Icons.person_add_outlined,
              onTap: () {
                // Handle Add Account
                _showFeatureNotImplementedDialog(context);
              },
            ),
            const SizedBox(height: 32),
            // Sign Out Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _signOut(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical:
                      12), // Consistent padding with your design
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        24), // Use the rounded border radius from your design
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.logout,
                        color:
                        Colors.white), // Use explicit color for consistency
                    SizedBox(width: 8),
                    Text('Sign Out',
                        style: TextStyle(
                            fontSize:
                            18)), // Consistent font size and style
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to build ListTile
  static Widget _buildListTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Colors
                      .grey))), //moved border here for visual separation
      child: ListTile(
        leading: Icon(icon, color: Colors.grey[600]),
        title: Text(title,
            style: const TextStyle(
                fontSize:
                16)), // Consistent font size.  Make TextStyle const
        trailing: const Icon(Icons.arrow_forward_ios,
            color: Colors
                .grey), // Use iOS style arrow, make const
        onTap: onTap,
        contentPadding:
        EdgeInsets.zero, // Removed extra padding, as requested
      ),
    );
  }

  void _showFeatureNotImplementedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Feature Not Implemented'),
        content: const Text('This feature is not yet available.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Function to sign out
  Future<void> _signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) =>
            const AuthScreen(), // Use the imported AuthScreen
          ),
        );
      }
    } catch (e) {
      // Handle sign-out errors,  show dialog to the user
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error Signing Out'),
            content: Text('An error occurred while signing out: $e'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }
}