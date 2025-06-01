import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:hackattack2025/components/user/bar_chart.dart';
import 'package:hackattack2025/components/appbar.dart';
import 'package:hackattack2025/components/navbar.dart';

class CompanyDetailPage extends StatefulWidget {
  final String companyName;
  final String imagePath;

  const CompanyDetailPage({
    super.key,
    required this.companyName,
    required this.imagePath,
  });

  @override
  State<CompanyDetailPage> createState() => _CompanyDetailPageState();
}

class _CompanyDetailPageState extends State<CompanyDetailPage> {
  DateTime? selectedDate;

  final List<DateTime> allowedDates = [
    DateTime(2025, 5, 17),
    DateTime(2025, 5, 18),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 255, 241),
      bottomNavigationBar: const Industrynavbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Industryappbar(),

            // Company Name
            Center(
              child: Text(
                widget.companyName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Company Image
            Image.asset(
              widget.imagePath,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),

            // Monitoring Summary
            const Text('Monitoring Summary',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
            const SizedBox(height: 12),

            // Date Picker
            GestureDetector(
              onTap: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: allowedDates.last,
                  firstDate: allowedDates.first,
                  lastDate: allowedDates.last,
                  selectableDayPredicate: (date) {
                    return allowedDates.any((d) =>
                    d.year == date.year &&
                        d.month == date.month &&
                        d.day == date.day);
                  },
                );
                if (pickedDate != null) {
                  setState(() {
                    selectedDate = pickedDate;
                  });
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.calendar_today, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      selectedDate != null
                          ? DateFormat('MMM dd yyyy')
                          .format(selectedDate!)
                          .toUpperCase()
                          : 'MAY 18 2025',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Tabs
            DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  const TabBar(
                    labelColor: Colors.black,
                    tabs: [
                      Tab(text: "Overall"),
                      Tab(text: "PM2.5"),
                      Tab(text: "PM10"),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height/1.7, // Let it fill the remaining space
                    child: TabBarView(
                      children: [
                        _buildOverallTab(),     // Will auto-size to content
                        _buildChartTab("PM2.5"),
                        _buildChartTab("PM10"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Content for "Overall" tab
  Widget _buildOverallTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Air Monitoring", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 4),
          Row(
            children: const [
              Text("Prediction: ", style: TextStyle(fontSize: 12)),
              Text("Polluted", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              SizedBox(width: 4),
              Icon(Icons.square, color: Colors.red, size: 14),
            ],
          ),
          const Text("Confidence: 82%", style: TextStyle(fontSize: 12)),
          const Text("Unhealthy metric:", style: TextStyle(fontSize: 12)),
          const Text("• PM2.5 µg/m³ – 26.5", style: TextStyle(fontSize: 12)),
          const SizedBox(height: 16),
          const Text("Water Monitoring", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 4),
          Row(
            children: const [
              Text("Prediction: ", style: TextStyle(fontSize: 12)),
              Text("No pollution", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              SizedBox(width: 4),
              Icon(Icons.square, color: Colors.green, size: 14),
            ],
          ),
          const Text("Confidence: 74%", style: TextStyle(fontSize: 12)),
          const Text("Unhealthy metric: None", style: TextStyle(fontSize: 12)),
          const SizedBox(height: 16),
          const Text("Soil Monitoring", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 4),
          Row(
            children: const [
              Text("Prediction: ", style: TextStyle(fontSize: 12)),
              Text("No pollution", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              SizedBox(width: 4),
              Icon(Icons.square, color: Colors.green, size: 14),
            ],
          ),
          const Text("Confidence: 88%", style: TextStyle(fontSize: 12)),
          const Text("Unhealthy metric: None", style: TextStyle(fontSize: 12)),
          const SizedBox(height: 24),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Download logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal, // Sets the button background color
              ),
              child: const Text("Download Dataset",style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildChartTab(String type) {
    final values = [15.0, 17.0, 24.0, 28.0, 28.0];
    final labels = ['0000', '0100', '0200', '0300', '0400'];

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            BarChartComponent(values: values, labels: labels),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Download logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal, // Sets the button background color
              ),
              child: const Text("Download Dataset",style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

}
