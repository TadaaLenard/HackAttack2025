import 'package:flutter/material.dart';

class ApiPricingCard extends StatelessWidget {
  final String title;
  final String price;
  final String unit;
  final List<String> features;
  final String buttonText;
  final VoidCallback onPressed;

  const ApiPricingCard({
    super.key,
    required this.title,
    required this.price,
    required this.unit,
    required this.features,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                title,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.teal),
                  children: [
                    TextSpan(
                      text: price,
                      style: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: ' $unit',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            ...features.map(
                  (f) =>
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text(
                      "• $f",
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
            ),
            const SizedBox(height: 12),
            Center(
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  buttonText,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
