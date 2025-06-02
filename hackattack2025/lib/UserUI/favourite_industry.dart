import 'package:flutter/material.dart';
import 'package:hackattack2025/components/appbar.dart';
import 'package:hackattack2025/components/navbar.dart';
import 'package:hackattack2025/components/user/company_card.dart';
import 'package:hackattack2025/components/user_navbar.dart';

class FavouriteIndustryPage extends StatefulWidget {
  const FavouriteIndustryPage({super.key});

  @override
  State<FavouriteIndustryPage> createState() => _FavouriteIndustryPageState();
}

class _FavouriteIndustryPageState extends State<FavouriteIndustryPage> {
  final double paddingval = 20.0;

  List<Map<String, String>> favoriteCompanies = [
    {
      'name': 'Yokogawa Malaysia',
      'image': 'assets/images/industry.png',
    },
  ];

  void _removeCompany(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Icon(Icons.warning, size: 40),
        content: Text('Remove ${favoriteCompanies[index]['name']} from favourite list?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                favoriteCompanies.removeAt(index);
              });
              _showRemovedDialog();
            },
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }

  void _showRemovedDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Icon(Icons.check_circle, color: Colors.green, size: 40),
        content: const Text("Removed from favourite list."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Ok"),
          ),
        ],
      ),
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

            const Text(
              "Favourite Industry",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            favoriteCompanies.isEmpty
                ? SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("No company available, add a new one!"),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                      ),
                      child: const Text(
                        "Main menu",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            )
                : ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: favoriteCompanies.length,
              itemBuilder: (context, index) {
                return CompanyCard(
                  companyName: favoriteCompanies[index]['name']!,
                  imagePath: favoriteCompanies[index]['image']!,
                  isFavorite: true,
                  onRemove: () => _removeCompany(index),
                  onToggleFavorite: () => _removeCompany(index),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const UserNavbar(),
    );
  }
}
