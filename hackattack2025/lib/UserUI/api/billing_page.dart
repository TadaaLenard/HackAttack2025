import 'package:flutter/material.dart';
import 'package:hackattack2025/components/appbar.dart';
import 'package:hackattack2025/components/navbar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hackattack2025/components/user/api_line_chart.dart';
import 'package:hackattack2025/components/user/api_monitoring_dashboard.dart';

class BillingPage extends StatelessWidget {

  const BillingPage({super.key});

  List<FlSpot> getChartData() {
    return const [
      FlSpot(1, 1),
      FlSpot(2, 0.8),
      FlSpot(3, 0.9),
      FlSpot(4, 3),
      FlSpot(5, 10),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 238, 255, 241),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: screenHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Industryappbar(),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Text(
                        "API Billing",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const TabBar(
                    labelColor: Colors.black,
                    indicatorColor: Colors.green,
                    tabs: [
                      Tab(text: 'March'),
                      Tab(text: 'April'),
                      Tab(text: 'May'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const ApiMonitoringDashboard(),
                  const SizedBox(height: 16),
                  const Text("API Requests (k)"),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 280,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0), // Adjust as needed
                        child: SizedBox(
                          width: 800, // Wide enough for all 31 days
                          child: ApiLineChart(data: getChartData()),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
                      ),
                      onPressed: () {
                        // Implement download logic
                      },
                      child: const Text("Download Bill",style: TextStyle(color:Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: const Industrynavbar(),
      ),
    );
  }
}
