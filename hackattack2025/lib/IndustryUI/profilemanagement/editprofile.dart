import 'package:flutter/material.dart';
import 'package:hackattack2025/components/customizedbutton.dart'; // Assuming this path is correct for GreenElevatedButton
import 'package:hackattack2025/components/labeltextfield.dart'; // Assuming this path is correct for LabeledTextField
import 'package:hackattack2025/components/navbar.dart'; // Assuming this path is correct
import 'package:hackattack2025/datamodel.dart'; // Assuming UserProfile is defined here
import 'package:hackattack2025/navigation/route.dart'; // Assuming AppRoutes is defined here

class Industryeditprofile extends StatefulWidget {
  final UserProfile userProfile;

  const Industryeditprofile({
    super.key,
    required this.userProfile,
  });

  @override
  State<Industryeditprofile> createState() => _IndustryeditprofileState();
}

class _IndustryeditprofileState extends State<Industryeditprofile> {
  final paddingval = 20.0;

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;
  // Re-added _usernameController and now it will be initialized from userProfile
  late TextEditingController _usernameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.userProfile.name);
    _emailController = TextEditingController(text: widget.userProfile.email);
    _addressController =
        TextEditingController(text: widget.userProfile.address ?? '');
    // Initialize username controller from widget.userProfile.username
    _usernameController =
        TextEditingController(text: widget.userProfile.username);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _usernameController.dispose(); // Re-added _usernameController disposal
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(paddingval),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.lightGreen,
                    child: widget.userProfile.profileImageUrl != null
                        ? ClipOval(
                            child: Image.network(
                              widget.userProfile.profileImageUrl!,
                              fit: BoxFit.cover,
                              width: 120,
                              height: 120,
                            ),
                          )
                        : const Icon(
                            Icons.person,
                            size: 70,
                            color: Colors.white,
                          ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.lightGreen,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: paddingval * 1.5),

            // Name Input Field using LabeledTextField
            LabeledTextField(
              label: 'Name',
              placeholder: 'Enter your name',
              controller: _nameController,
            ),
            SizedBox(height: paddingval),

            // Username Input Field using LabeledTextField
            LabeledTextField(
              label: 'Username',
              placeholder: 'Enter your username',
              controller: _usernameController,
            ),
            SizedBox(height: paddingval),

            // Email Input Field using LabeledTextField
            LabeledTextField(
              label: 'Email',
              placeholder: 'Enter your email address',
              controller: _emailController,
            ),
            SizedBox(height: paddingval),

            // Address Input Field using LabeledTextField
            LabeledTextField(
              label: 'Address',
              placeholder: 'Enter your full address',
              controller: _addressController,
            ),
            SizedBox(height: paddingval * 2),

            // Save Changes Button using GreenElevatedButton
            const SizedBox(
              width: double.infinity,
              child: GreenElevatedButton(
                text: 'Save Changes',
                navigateTo: AppRoutes.industryprofilelist,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Industrynavbar(),
    );
  }
}
