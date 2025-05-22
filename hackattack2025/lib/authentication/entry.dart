import 'package:flutter/material.dart';
import 'package:hackattack2025/components/customizedbutton.dart';
import 'package:hackattack2025/navigation/route.dart';

class Userentry extends StatefulWidget {
  const Userentry({super.key});

  @override
  State<Userentry> createState() => _UserentryState();
}

class _UserentryState extends State<Userentry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(102, 183, 255, 196)
            ],
            begin: Alignment.topLeft, // Starting point of gradient
            end: Alignment.bottomRight, // Ending point of gradient
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 300,
                fit: BoxFit.fitWidth,
              ),
              const SizedBox(
                height: 100,
              ),
              const Text(
                'Explore The App',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                width: 350,
                child: Text(
                  'Now your monitoring system are in one place and always under control',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const GreenElevatedButton(
                text: 'Sign In',
                navigateTo: AppRoutes.signup,
              ),
              const SizedBox(
                height: 10,
              ),
              const WhiteElevatedButton(
                text: 'Create Account',
                navigateTo: AppRoutes.signup,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
