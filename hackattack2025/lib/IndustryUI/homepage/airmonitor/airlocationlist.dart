import 'package:flutter/material.dart';
import 'package:hackattack2025/components/appbar.dart';
import 'package:hackattack2025/components/navbar.dart';
import 'package:hackattack2025/datamodel.dart';
import 'package:hackattack2025/navigation/route.dart';

class Airlocationlist extends StatefulWidget {
  const Airlocationlist({super.key});

  @override
  State<Airlocationlist> createState() => _AirlocationlistState();
}

class _AirlocationlistState extends State<Airlocationlist> {
  final paddingval = 20.0;
  final TextEditingController _searchController = TextEditingController();

  List<SensorStack> sensors = [
    SensorStack(
        stackName: 'Calcination Unit - Stack 1',
        lastReading: '18/05/2025 10:30:25',
        status: 'Normal'),
    SensorStack(
        stackName: 'Calcination Unit - Stack 2',
        lastReading: '18/05/2025 10:30:25',
        status: 'Warning'),
    SensorStack(
        stackName: 'Calcination Unit - Stack 3',
        lastReading: '18/05/2025 10:30:25',
        status: 'Normal'),
  ];

  String searchTerm = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredSensors = sensors
        .where((sensor) =>
            sensor.stackName.toLowerCase().contains(searchTerm.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(paddingval),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const Industryappbar(
              showBackButton: true,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Air Monitoring Locations',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SearchBarWidget(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  searchTerm = value;
                });
              },
            ),
            const SizedBox(height: 10),
            filteredSensors.isEmpty
                ? const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Center(
                      child: Text(
                        'No sensors found',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: filteredSensors.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return SensorCard(
                        sensor: filteredSensors[index],
                        appRoute: AppRoutes.airlocationstats,
                      );
                    },
                  ),
          ],
        ),
      ),
      bottomNavigationBar: const Industrynavbar(),
    );
  }
}

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: "Search by sensor ID, type or location",
        hintStyle: const TextStyle(fontSize: 12),
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

class SensorCard extends StatelessWidget {
  final SensorStack sensor;
  final String appRoute;

  const SensorCard({super.key, required this.sensor, required this.appRoute});

  Color getBorderColor() {
    switch (sensor.status.toLowerCase()) {
      case 'normal':
        return Colors.green;
      case 'warning':
        return Colors.orange;
      case 'critical':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color getTextColor() {
    switch (sensor.status.toLowerCase()) {
      case 'normal':
        return Colors.green;
      case 'warning':
        return Colors.orange;
      case 'critical':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(
          context,
          appRoute,
          arguments: sensor.stackName,
        );
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        elevation: 0, // removes shadow
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: getBorderColor(), width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sensor.stackName,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text("Last reading: ${sensor.lastReading}"),
            const SizedBox(height: 4),
            Row(
              children: [
                const Text(
                  "Status: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  sensor.status,
                  style: TextStyle(color: getTextColor()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
