import 'package:flutter/material.dart';
import 'package:hackattack2025/datamodel.dart';
import 'package:hackattack2025/navigation/route.dart';

class Sensorscontent extends StatefulWidget {
  final String label;
  const Sensorscontent({super.key, required this.label});

  @override
  State<Sensorscontent> createState() => _SensorscontentState();
}

class _SensorscontentState extends State<Sensorscontent> {
  final paddingval = 20.0;
  final TextEditingController _searchController = TextEditingController();

  // Updated dummy data to match the new SensorData model and image
  List<SensorData> sensors = [
    const SensorData(
      sensorId: 'PM25-20240517-126',
      sensorType: 'Particulate Matter ≤2.5 µm (PM2.5)',
      lastReading: '18/05/2025 10:30:25',
      location: 'Calcination Unit - Stack 2',
    ),
    const SensorData(
      sensorId: 'PM25-20240517-246',
      sensorType: 'Particulate Matter ≤2.5 µm (PM2.5)',
      lastReading: '18/05/2025 10:30:25',
      location: 'Calcination Unit - Stack 2',
    ),
    // Added more dummy data
    const SensorData(
      sensorId: 'CO2-20240517-001',
      sensorType: 'Carbon Dioxide (CO2)',
      lastReading: '18/05/2025 11:00:00',
      location: 'Boiler Room - Exhaust 1',
    ),
    const SensorData(
      sensorId: 'SO2-20240517-005',
      sensorType: 'Sulfur Dioxide (SO2)',
      lastReading: '18/05/2025 11:15:30',
      location: 'Chemical Plant - Vent 3',
    ),
    const SensorData(
      sensorId: 'NOX-20240517-010',
      sensorType: 'Nitrogen Oxides (NOx)',
      lastReading: '18/05/2025 11:45:10',
      location: 'Power Generation - Stack A',
    ),
    const SensorData(
      sensorId: 'O3-20240517-015',
      sensorType: 'Ozone (O3)',
      lastReading: '18/05/2025 12:05:00',
      location: 'Perimeter Fence - Sensor 5',
    ),
    const SensorData(
      sensorId: 'PM10-20240517-300',
      sensorType: 'Particulate Matter ≤10 µm (PM10)',
      lastReading: '18/05/2025 12:30:00',
      location: 'Dust Collection Unit - Output',
    ),
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
            sensor.sensorId.toLowerCase().contains(searchTerm.toLowerCase()) ||
            sensor.sensorType
                .toLowerCase()
                .contains(searchTerm.toLowerCase()) ||
            sensor.location.toLowerCase().contains(searchTerm.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        // This Column is now the direct child of Scaffold body
        crossAxisAlignment:
            CrossAxisAlignment.start, // Align children to the start
        children: [
          Padding(
            // Apply padding to the top section
            padding: EdgeInsets.all(paddingval),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Connected Sensors',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 10), // Added spacing below title
                SensorSearchBar(
                  // Renamed SearchBarWidget
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      searchTerm = value;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            // Wrap ListView.builder with Expanded to take remaining space
            child: filteredSensors.isEmpty
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
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            paddingval), // Apply horizontal padding here
                    itemCount: filteredSensors.length,
                    itemBuilder: (context, index) {
                      return SensorLocationCard(
                        // Renamed SensorCard
                        sensor: filteredSensors[index],
                        appRoute:
                            '', // AppRoutes.airlocationstats will be used for navigation
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// Renamed SearchBarWidget to SensorSearchBar
class SensorSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const SensorSearchBar({
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
        hintText:
            "Search by sensor ID or type", // Updated hint text as per image
        hintStyle: const TextStyle(fontSize: 12),
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

// Renamed SensorCard to SensorLocationCard and updated its content
class SensorLocationCard extends StatelessWidget {
  final SensorData sensor; // Changed type to SensorData
  final String appRoute;

  const SensorLocationCard(
      {super.key, required this.sensor, required this.appRoute});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(
          context,
          AppRoutes.airsensordata,
          arguments: sensor, // Pass the entire sensor object as argument
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
          border: Border.all(
              color: Colors.grey[300]!,
              width: 2), // Consistent grey border as per image
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sensor.sensorId, // Display sensor ID as main title
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 4),
            Text(
              sensor.sensorType, // Display sensor type/description
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            const SizedBox(height: 4),
            Text(
              "Last reading: ${sensor.lastReading}",
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.location_on,
                    size: 16, color: Colors.grey[700]), // Location icon
                const SizedBox(width: 4),
                Text(
                  sensor.location, // Display location
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
