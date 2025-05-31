import 'package:flutter/material.dart';
import 'package:hackattack2025/components/navbar.dart';
import 'package:hackattack2025/datamodel.dart';
import 'package:hackattack2025/navigation/route.dart';

class Industryprofilelist extends StatefulWidget {
  const Industryprofilelist({
    super.key,
  });

  @override
  State<Industryprofilelist> createState() => _IndustryprofilelistState();
}

class _IndustryprofilelistState extends State<Industryprofilelist> {
  final paddingval = 20.0;

  // Dummy user data - now including username
  final UserProfile _currentUser = UserProfile(
    name: 'Heart Attack 2.0 Sdn Bhd',
    email: 'heartattack2@gmail.com',
    username: 'heartattack2', // Added dummy username
    address:
        '123, Industrial Park, 11700 Gelugor, Penang', // Added dummy address
    // You can add a profile image URL here if you have one
    // profileImageUrl: 'https://example.com/profile.png',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true, // Center the title as seen in the image
        // The back button will automatically appear if this screen is pushed onto a Navigator stack.
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(paddingval),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Header Section
                Row(
                  children: [
                    // Profile Picture/Icon
                    CircleAvatar(
                      radius: 40,
                      backgroundColor:
                          Colors.lightGreen, // Green background for the icon
                      child: _currentUser.profileImageUrl != null
                          ? ClipOval(
                              child: Image.network(
                                _currentUser.profileImageUrl!,
                                fit: BoxFit.cover,
                                width: 80,
                                height: 80,
                              ),
                            )
                          : const Icon(
                              Icons.person, // Default person icon
                              size: 50,
                              color: Colors.white,
                            ),
                    ),
                    SizedBox(width: paddingval),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _currentUser.name,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            _currentUser.username, // Display the username
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Colors.grey[600],
                                ),
                          ),
                          Text(
                            _currentUser.email,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Colors.grey[600],
                                ),
                          ),
                          // Display the address if it exists
                          if (_currentUser.address != null &&
                              _currentUser.address!.isNotEmpty)
                            Text(
                              _currentUser.address!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                            ),
                          const SizedBox(height: 8),
                          // Edit Profile Button
                          SizedBox(
                            width: double
                                .infinity, // This makes the button expand horizontally
                            child: ElevatedButton(
                              onPressed: () {
                                // Navigate to the Industryeditprofile screen
                                // and pass the current user profile as an argument.
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.industryeditprofile,
                                  arguments: _currentUser,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors
                                    .lightGreen, // Button background color
                                foregroundColor: Colors.white, // Text color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      8), // Rounded corners
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                              ),
                              child: const Text('Edit Profile'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                    height:
                        paddingval / 2), // Reduced spacing before list items
              ],
            ),
          ),
          // Profile List Items
          Expanded(
            // Use Expanded to make the Column take available space
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingval),
              child: Column(
                // Changed from ListView to Column
                mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly, // Distribute children evenly
                children: [
                  _buildProfileListItem(
                    context,
                    icon: Icons.language,
                    text: 'Language',
                    onTap: () {},
                  ),
                  _buildProfileListItem(
                    context,
                    icon: Icons.lock,
                    text: 'Change password',
                    onTap: () {},
                  ),
                  _buildProfileListItem(
                    context,
                    icon: Icons
                        .person_remove, // Using person_remove for delete account
                    text: 'Delete account',
                    onTap: () {},
                  ),
                  _buildProfileListItem(
                    context,
                    icon: Icons.logout,
                    text: 'Logout',
                    isLogout: true, // Special styling for logout
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRoutes.login,
                        ModalRoute.withName(AppRoutes.userentry),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const Industrynavbar(),
    );
  }

  // Helper method to build consistent profile list items
  Widget _buildProfileListItem(
    BuildContext context, {
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    bool isLogout = false, // Flag for logout button styling
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            icon,
            color: isLogout ? Colors.red : Colors.black, // Red icon for logout
          ),
          title: Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: isLogout
                      ? Colors.red
                      : Colors.black, // Red text for logout
                ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: onTap,
        ),
        Divider(height: 1, color: Colors.grey[300]), // Divider between items
      ],
    );
  }
}
