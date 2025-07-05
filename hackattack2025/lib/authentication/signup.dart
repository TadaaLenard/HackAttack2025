import 'package:flutter/material.dart';
import 'package:hackattack2025/components/customizedbutton.dart';
import 'package:hackattack2025/components/labeltextfield.dart';
import 'package:hackattack2025/navigation/route.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final paddingval = 20.0;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool _isLoading = false; // State to manage loading indicator

  // Function to show a SnackBar message
  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // Function to handle user registration
  Future<void> _registerUser() async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });

    // Basic validation
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty ||
        confirmPasswordController.text.trim().isEmpty) {
      _showSnackBar('Please fill in all required fields.', isError: true);
      setState(() {
        _isLoading = false;
      });
      return;
    }

    if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      _showSnackBar('Passwords do not match.', isError: true);
      setState(() {
        _isLoading = false;
      });
      return;
    }

    if (passwordController.text.trim().length < 6) {
      _showSnackBar('Password must be at least 6 characters long.',
          isError: true);
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      // Create user with Firebase Authentication
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // If registration is successful
      if (userCredential.user != null) {
        // Optionally, update user profile (e.g., display name)
        await userCredential.user!.updateDisplayName(
          '${firstNameController.text.trim()} ${lastNameController.text.trim()}',
        );

        _showSnackBar(
            'Registration successful! Please proceed to address details.');
        print('User registered: ${userCredential.user?.email}');

        // Navigate to the next screen (SUaddress)
        Navigator.pushReplacementNamed(context, AppRoutes.suaddress);
      }
    } on FirebaseAuthException catch (e) {
      // Handle Firebase authentication errors
      String errorMessage;
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'The email address is not valid.';
      } else {
        errorMessage = 'Firebase Auth Error: ${e.message}';
      }
      _showSnackBar(errorMessage, isError: true);
      print('Firebase Auth Error: $e');
    } catch (e) {
      // Handle other potential errors
      _showSnackBar('An unexpected error occurred: $e', isError: true);
      print('General Error: $e');
    } finally {
      setState(() {
        _isLoading = false; // Hide loading indicator
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(paddingval),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Sign Up',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: paddingval,
                ),
                Row(
                  children: [
                    Expanded(
                      child: LabeledTextField(
                        label: 'First Name',
                        placeholder: 'John',
                        controller: firstNameController,
                      ),
                    ),
                    SizedBox(
                      width: paddingval,
                    ),
                    Expanded(
                      child: LabeledTextField(
                        label: 'Last Name',
                        placeholder: 'Doe',
                        controller: lastNameController,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: paddingval,
                ),
                LabeledTextField(
                  label: 'Email',
                  placeholder: 'example@gmail.com',
                  controller: emailController,
                ),
                SizedBox(
                  height: paddingval,
                ),
                LabeledTextField(
                  label: 'Create a password',
                  placeholder: 'must be 8 characters',
                  controller: passwordController,
                  isPrivate: true,
                ),
                SizedBox(
                  height: paddingval,
                ),
                LabeledTextField(
                  label: 'Confirm password',
                  placeholder: 'repeat password',
                  controller: confirmPasswordController,
                  isPrivate: true,
                ),
                SizedBox(
                  height: paddingval,
                ),
                _isLoading // Show CircularProgressIndicator if loading
                    ? const CircularProgressIndicator()
                    : GreenElevatedButton(
                        text: 'Proceed',
                        // Call the registration method instead of directly navigating
                        onPressed: _registerUser,
                      ),
                SizedBox(
                  height: paddingval,
                ),
                const Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Color.fromARGB(255, 0, 0, 0),
                        thickness: 1,
                      ),
                    ),
                    Text('   Or Register with   '),
                    Expanded(
                      child: Divider(
                        color: Color.fromARGB(255, 0, 0, 0),
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: paddingval),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ThirdPartyElevatedButton(label: 'facebook'),
                    ThirdPartyElevatedButton(label: 'google'),
                    ThirdPartyElevatedButton(label: 'apple')
                  ],
                ),
                SizedBox(height: paddingval),
                const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(),
                      ),
                      CustomTextButton(
                        label: 'Log in',
                        destinationRoute: AppRoutes.login,
                      ),
                    ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Your SUaddress class remains unchanged as it's not part of the current Firebase Auth integration
class SUaddress extends StatefulWidget {
  const SUaddress({super.key});

  @override
  State<SUaddress> createState() => _SUaddressState();
}

class _SUaddressState extends State<SUaddress> {
  final paddingval = 20.0;
  final TextEditingController companyController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController postcodeController = TextEditingController();
  final TextEditingController stateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(paddingval),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Sign Up - Address',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: paddingval,
                ),
                LabeledTextField(
                  label: 'Company Name',
                  placeholder: 'Industry Sdn Bhd',
                  controller: companyController,
                ),
                SizedBox(
                  height: paddingval,
                ),
                LabeledTextField(
                  label: 'Address',
                  placeholder: 'Location of the company',
                  controller: addressController,
                ),
                SizedBox(
                  height: paddingval,
                ),
                LabeledTextField(
                  label: 'Postcode',
                  placeholder: 'Postcode',
                  controller: postcodeController,
                ),
                SizedBox(
                  height: paddingval,
                ),
                LabeledTextField(
                  label: 'State',
                  placeholder: 'State',
                  controller: stateController,
                ),
                SizedBox(
                  height: paddingval,
                ),
                const GreenElevatedButton(
                    text: 'Sign Up', navigateTo: AppRoutes.signup),
                SizedBox(
                  height: paddingval,
                ),
                const Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Color.fromARGB(255, 0, 0, 0),
                        thickness: 1,
                      ),
                    ),
                    Text('   Or Register with   '),
                    Expanded(
                      child: Divider(
                        color: Color.fromARGB(255, 0, 0, 0),
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: paddingval),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ThirdPartyElevatedButton(label: 'facebook'),
                    ThirdPartyElevatedButton(label: 'google'),
                    ThirdPartyElevatedButton(label: 'apple')
                  ],
                ),
                SizedBox(height: paddingval),
                const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(),
                      ),
                      CustomTextButton(
                        label: 'Log in',
                        destinationRoute: AppRoutes.login,
                      ),
                    ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
