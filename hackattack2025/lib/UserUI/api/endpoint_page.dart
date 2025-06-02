import 'package:flutter/material.dart';
import 'package:hackattack2025/components/appbar.dart';
import 'package:hackattack2025/components/navbar.dart';
import 'package:hackattack2025/components/user/api_card.dart';
import 'package:hackattack2025/components/user_navbar.dart';

class EndpointPage extends StatelessWidget {
  const EndpointPage({super.key});

  final String sampleCode = '''
GET /realtime?sensor=pm10&lat=5.4&long=100.3
''';

  final String sampleCode2 = '''
{
  "sensor": "pm10",
  "unit": "µg/m³",
  "timestamp": "2025-05-27T15:30:00Z",
  "location": {
    "lat": 5.4,
    "long": 100.3
  },
  "value": 82,
  "status": "moderate"
}
''';

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
                      Navigator.pop(context); // Go back to the previous page
                    },
                  ),
                  const Text(
                    "API Endpoint",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.description, color: Colors.blue),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Redirect to documentation")),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 8),

              ApiEndpointCard(
                title: "Get Realtime Data from a position",
                description: "Return latest sensor reading by type and position.",
                requestCode: sampleCode,
                responseCode: sampleCode2,
              ),
              const SizedBox(height: 12),
              ApiEndpointCard(
                title: "Get Realtime Data within a location",
                description: "Return all sensor readings in a radius.",
                requestCode: sampleCode,
                responseCode: sampleCode2,
              ),
              const SizedBox(height: 12),
              ApiEndpointCard(
                title: "Get Historical Trends from a location",
                description: "Return time-series data.",
                requestCode: sampleCode,
                responseCode: sampleCode2,
              ),
              const SizedBox(height: 12),
              ApiEndpointCard(
                title: "Get Alert Locations",
                description: "Return times/locations where sensor readings exceeded threshold.",
                requestCode: sampleCode,
                responseCode: sampleCode2,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const UserNavbar(),
    );
  }
}
