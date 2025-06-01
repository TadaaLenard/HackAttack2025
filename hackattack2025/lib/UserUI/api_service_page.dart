import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hackattack2025/components/appbar.dart';
import 'package:hackattack2025/components/navbar.dart';
import 'package:hackattack2025/components/user/api_line_chart.dart';
import 'package:hackattack2025/components/user/api_monitoring_dashboard.dart';
import '../components/user/api_key_table.dart';
import 'api/billing_page.dart';
import 'api/endpoint_page.dart';
import 'api/subservice_page.dart';

class ApiServicePage extends StatefulWidget {
  const ApiServicePage({super.key});

  @override
  State<ApiServicePage> createState() => _ApiServicePageState();
}

class _ApiServicePageState extends State<ApiServicePage> {
  List<Map<String, String>> apiKeys = [
    {'key': '1234-ABCD-5678', 'description': 'Test', 'expires': '-'},
    {'key': 'ZXCV-9999-TEST', 'description': 'Backup', 'expires': '2026-01-01'},
  ];

  List<FlSpot> getChartData() {
    return const [
      FlSpot(1, 1),
      FlSpot(2, 0.8),
      FlSpot(3, 0.9),
      FlSpot(4, 3),
      FlSpot(5, 10),
    ];
  }

  void handleDelete(int index) {
    setState(() {
      apiKeys.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 255, 241),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Industryappbar(),
                const SizedBox(height: 20),
                const Text(
                  "API Service",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Fast and reliable. Create your own exclusive API key today and enjoy the trusted industry data!",
                  style: TextStyle(fontSize: 10),
                ),
                const SizedBox(height: 20),

                // Circle navigation buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _circleNavButton(context, Icons.receipt_long, "Bill", const BillingPage()),
                    _circleNavButton(context, Icons.local_offer, "Services", const SubServicePage()),
                    _circleNavButton(context, Icons.code, "Endpoints", const EndpointPage()),
                  ],
                ),
                const SizedBox(height: 30),

                const Text("My API keys", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),

                Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const SubServicePage()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    ),
                    child: const Text(
                      "Generate API key",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                apiKeys.isEmpty
                    ? Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    decoration: BoxDecoration(
                      color: Color(0xFFE1F2D3),
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "No API key, create new one",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              :
                ApiKeyTable(
                  apiKeys: apiKeys,
                  onDelete: handleDelete,
                ),

                const SizedBox(height: 30),
                const ApiMonitoringDashboard(),
                const SizedBox(height: 16),
                const Text("API Requests (k)", style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),

                SizedBox(
                  height: 280,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                      child: SizedBox(
                        width: 800,
                        child: ApiLineChart(data: getChartData()),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const Industrynavbar(),
    );
  }

  Widget _circleNavButton(BuildContext context, IconData icon, String label, Widget page) {
    return Column(
      children: [
        InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: Icon(icon, size: 28, color: Colors.teal),
          ),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 13)),
      ],
    );
  }
}

