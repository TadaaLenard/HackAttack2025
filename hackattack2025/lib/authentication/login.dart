import 'package:flutter/material.dart';
import 'package:hackattack2025/components/customizedbutton.dart';
import 'package:hackattack2025/components/labeltextfield.dart';
import 'package:hackattack2025/navigation/route.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:http/http.dart'
    as http; // Import http package for backend calls

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final paddingval = 20.0;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false; // State to manage loading indicator

  // IMPORTANT: For Android Emulator, use 'http://10.0.2.2:3000' to access your host machine's localhost.
  // For physical device or iOS Simulator, 'http://localhost:3000' might work, or use your machine's actual IP address.
  final String _backendBaseUrl =
      'http://10.0.2.2:3000'; // Modified for Android Emulator compatibility

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

  // Function to handle user login
  Future<void> _loginUser() async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });

    try {
      // 1. Authenticate with Firebase
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // If authentication is successful, get the ID token
      User? user = userCredential.user;
      if (user != null) {
        String? idToken = await user.getIdToken(true); // Force refresh token

        if (idToken != null) {
          // 2. Send ID token to Node.js backend for verification
          final response = await http.get(
            Uri.parse(
                '$_backendBaseUrl/protected-route'), // Your protected backend route
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $idToken', // Send the ID token
            },
          );

          if (response.statusCode == 200) {
            _showSnackBar('Login successful and backend verified!');
            print('Backend response: ${response.body}');

            // Proceed to navigate based on user role (as in your original code)
            final prefs = await SharedPreferences.getInstance();
            final role = prefs.getString('user_role') ??
                'Normal User'; // This role should ideally come from your backend after verification

            Navigator.pushReplacementNamed(
              // Use pushReplacementNamed to prevent going back to login
              context,
              role == 'Industry'
                  ? AppRoutes.industryhomepage
                  : AppRoutes.userhomepage,
            );
          } else {
            // Backend verification failed
            _showSnackBar('Backend verification failed: ${response.statusCode}',
                isError: true);
            print(
                'Backend verification failed: ${response.statusCode} - ${response.body}');
          }
        } else {
          _showSnackBar('Failed to get Firebase ID token.', isError: true);
        }
      }
    } on FirebaseAuthException catch (e) {
      // Handle Firebase authentication errors
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'The email address is not valid.';
      } else {
        errorMessage = 'Firebase Auth Error: ${e.message}';
      }
      _showSnackBar(errorMessage, isError: true);
      print('Firebase Auth Error: $e');
    } catch (e) {
      // Handle other potential errors (e.g., network issues)
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
                    'Hi, Welcome!',
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
                  label: 'Password',
                  placeholder: 'must be 8 characters',
                  controller: passwordController,
                  isPrivate: true,
                ),
                SizedBox(
                  height: paddingval,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CheckButton(),
                        SizedBox(
                          width: 5,
                        ),
                        Text('Remember Me'),
                      ],
                    ),
                    CustomTextButton(
                      label: 'Forgot Password?',
                      destinationRoute: AppRoutes.forgetpassword,
                      textColor: Colors.black,
                    ),
                  ],
                ),
                SizedBox(
                  height: paddingval,
                ),
                _isLoading // Show CircularProgressIndicator if loading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF078077),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                        onPressed: _loginUser, // Call the new login method
                        child: const Text('Log in'),
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
                    Text('   Or Login with   '),
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
                        "Don't have an account?",
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      CustomTextButton(
                        label: 'Sign up',
                        fontSize: 17,
                        destinationRoute: AppRoutes.signup,
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
