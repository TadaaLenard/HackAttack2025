import 'package:flutter/material.dart';
import 'package:hackattack2025/components/appbar.dart';
import 'package:hackattack2025/components/navbar.dart';
import 'package:hackattack2025/components/user_navbar.dart';
import 'package:hackattack2025/navigation/route.dart';
import 'package:hackattack2025/components/user/company_card.dart'; // Add this line
import 'package:hugeicons/hugeicons.dart';

class Userhomepage extends StatefulWidget {
  const Userhomepage({super.key});

  @override
  State<Userhomepage> createState() => _UserhomepageState();
}

class _UserhomepageState extends State<Userhomepage> {
  final paddingval = 20.0;
  final username = "Heart Attack 2.0";

  @override
  void initState() {
    super.initState();

    // Delay to ensure context is available before showing the dialog
    Future.delayed(Duration.zero, () {
      _showLocationPermissionDialog();
    });
  }

  void _showLocationPermissionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Icon(Icons.warning_amber_rounded, size: 40),
          content: const Text("Allow application to access to your location?"),
          actions: [
            TextButton(
              child: const Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop();
                // Add location permission logic here if needed
              },
            ),
            TextButton(
              child: const Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
                // Optionally disable location-based features
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 255, 241),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(paddingval),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Industryappbar(),
            Text('Hi, $username!', style: const TextStyle(fontSize: 17)),
            const Text('Welcome back!'),
            const SizedBox(height: 10),
            Image.asset(
              'assets/images/map2.png',
              width: MediaQuery.of(context).size.width,
            ),
            const SizedBox(height: 10),
            // Search bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search by company name',
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Nearby Industry', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            CompanyCard(
              companyName: 'Yokogawa Malaysia',
              imagePath: 'assets/images/industry.png',
              isFavorite: true, // or false depending on the state
              onRemove: () {
                // Optional: You can call this if needed, or leave it as a no-op
              },
              onToggleFavorite: () {
                // Implement logic to toggle favorite status
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: const UserNavbar(),
    );
  }
}
