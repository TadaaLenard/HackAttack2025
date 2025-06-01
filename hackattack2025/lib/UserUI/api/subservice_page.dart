import 'package:flutter/material.dart';
import 'package:hackattack2025/components/appbar.dart';
import 'package:hackattack2025/components/navbar.dart';
import 'package:hackattack2025/components/user/api_pricing_card.dart';

class SubServicePage extends StatelessWidget {
  const SubServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 255, 241),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Industryappbar(),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Text(
                    "API Service",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 4),

              // Free Plan Card
              ApiPricingCard(
                title: "Free",
                price: "RM0",
                unit: "/month",
                features: const [
                  "20 requests / month",
                ],
                buttonText: "Start Free Trial",
                onPressed: () {
                  showSubscriptionDialog(context, "Free");
                },
              ),

              const SizedBox(height: 16),

              // Pay As You Go Card
              ApiPricingCard(
                title: "Pay As You Go",
                price: "RM50",
                unit: "/1000 req",
                features: const [
                  "Flexible usage: Pay only for what you use",
                  "No monthly commitments",
                  "Ideal for low to moderate traffic",
                ],
                buttonText: "Subscribe",
                onPressed: () {
                  showSubscriptionDialog(context, "Pay As You Go");
                },

              ),

              const SizedBox(height: 16),

              ApiPricingCard(
                title: "Grow",
                price: "RM100",
                unit: "/month",
                features: const [
                  "Unlimited Access: Unlimited API requests for 1 month",
                  "Worry-Free Usage: No need to track request counts.",
                  "Ideal for growing apps and heavy usage.",
                ],
                buttonText: "Subscribe",
                onPressed: () {
                  showSubscriptionDialog(context, "Grow");
                },

              ),

              const SizedBox(height: 16),

              ApiPricingCard(
                title: "Pro",
                price: "RM550",
                unit: "/6 months",
                features: const [
                  "Save up to RM50",
                  "Unlimited Access: Unlimited API requests for 6 months.",
                  "Great value for long-term use.",
                ],
                buttonText: "Subscribe",
                onPressed: () {
                  showSubscriptionDialog(context, "Pro");
                },

              ),

              const SizedBox(height: 16),

              ApiPricingCard(
                title: "Enterprise",
                price: "RM1000",
                unit: "/year",
                features: const [
                  "Save up to RM200",
                  "Unlimited Access: Unlimited API requests for 1 year.",
                  "Ideal for established businesses.",
                ],
                buttonText: "Subscribe",
                onPressed: () {
                  showSubscriptionDialog(context, "Pro");
                },

              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Industrynavbar(),
    );
  }
}

Future<void> showSubscriptionDialog(BuildContext context, String plan) async {
  final TextEditingController descriptionController = TextEditingController();

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Subscription Confirmation', textAlign: TextAlign.center),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Align(alignment: Alignment.centerLeft, child: Text('Subscription Type')),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Text(plan),
                    const Spacer(),
                    const Icon(Icons.check_circle, color: Colors.teal),
                  ],
                ),
              ),
              const Align(alignment: Alignment.centerLeft, child: Text('Description')),
              const SizedBox(height: 8),
              TextField(
                controller: descriptionController,
                maxLines: 4,
                minLines: 2,
                decoration: const InputDecoration(
                  hintText: 'Your description',
                  filled: true,
                  fillColor: Color(0xFFF3F4F6),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(dialogContext).pop(); // Close dialog safely

              // Wait a moment to ensure the pop is fully completed
              await Future.delayed(const Duration(milliseconds: 100));

              // Then show next dialog
              if (context.mounted) {
                await proceedWithSubscription(context);
              }
            },
            child: const Text('Confirm', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      );
    },
  );
}


Future<void> proceedWithSubscription(BuildContext context) async {
  // Dialog context for closing loading dialog
  late BuildContext dialogContext;

  // Show loading dialog
  showDialog(
    context: context,
    barrierDismissible: false,
    useRootNavigator: true,
    builder: (BuildContext ctx) {
      dialogContext = ctx;
      return const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 16),
            Text("Creating API Key..."),
          ],
        ),
      );
    },
  );

  // Simulate API call delay
  await Future.delayed(const Duration(seconds: 2));

  // Fake API Key (replace this with real one later)
  const String generatedApiKey = "sk-test-4u2uRAnd0mK3y123";

  // Close loading dialog
  Navigator.of(dialogContext).pop();

  // Show success dialog with API key
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text("Success"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("API key successfully created!"),
          const SizedBox(height: 12),
          const Text("Your API Key:", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          SelectableText(
            generatedApiKey,
            style: const TextStyle(
              color: Colors.teal,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("OK"),
        ),
      ],
    ),
  );
}

