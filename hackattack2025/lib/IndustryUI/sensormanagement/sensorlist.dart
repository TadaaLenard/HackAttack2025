import 'package:flutter/material.dart';
import 'package:hackattack2025/IndustryUI/homepage/airmonitor/airlocationlist.dart';
import 'package:hackattack2025/components/appbar.dart';
import 'package:hackattack2025/components/customizedbutton.dart';
import 'package:hackattack2025/components/navbar.dart';
import 'package:hackattack2025/datamodel.dart';
import 'package:hackattack2025/navigation/route.dart';

class Sensorlist extends StatefulWidget {
  const Sensorlist({super.key});

  @override
  State<Sensorlist> createState() => _SensorlistState();
}

class _SensorlistState extends State<Sensorlist> {
  final paddingval = 20.0;
  final TextEditingController _searchController = TextEditingController();

  // Updated dummy data to match the new SensorData model and image
  List<SensorData> sensors = [
    const SensorData(
      sensorId: 'PM25-20240517-126',
      sensorType: 'Particulate Matter ≤2.5 µm (PM2.5)',
      lastReading: '18/05/2025 10:30:25',
      installationDate: '18/05/2025', // Added installationDate
      location: 'Calcination Unit - Stack 2',
    ),
    const SensorData(
      sensorId: 'PM25-20240517-246',
      sensorType: 'Particulate Matter ≤2.5 µm (PM2.5)',
      lastReading: '18/05/2025 10:30:25',
      installationDate: '18/05/2025', // Added installationDate
      location: 'Calcination Unit - Stack 2',
    ),
    // Added more dummy data
    const SensorData(
      sensorId: 'CO2-20240517-001',
      sensorType: 'Carbon Dioxide (CO2)',
      lastReading: '18/05/2025 11:00:00',
      installationDate: '18/05/2025 11:00:00', // Added installationDate
      location: 'Boiler Room - Exhaust 1',
    ),
    const SensorData(
      sensorId: 'SO2-20240517-005',
      sensorType: 'Sulfur Dioxide (SO2)',
      lastReading: '18/05/2025 11:15:30',
      installationDate: '18/05/2025', // Added installationDate
      location: 'Chemical Plant - Vent 3',
    ),
    const SensorData(
      sensorId: 'NOX-20240517-010',
      sensorType: 'Nitrogen Oxides (NOx)',
      lastReading: '18/05/2025 11:45:10',
      installationDate: '18/05/2025 11:45:10', // Added installationDate
      location: 'Power Generation - Stack A',
    ),
    const SensorData(
      sensorId: 'O3-20240517-015',
      sensorType: 'Ozone (O3)',
      lastReading: '18/05/2025 12:05:00',
      installationDate: '18/05/2025', // Added installationDate
      location: 'Perimeter Fence - Sensor 5',
    ),
    const SensorData(
      sensorId: 'PM10-20240517-300',
      sensorType: 'Particulate Matter ≤10 µm (PM10)',
      lastReading: '18/05/2025 12:30:00',
      installationDate: '18/05/2025', // Added installationDate
      location: 'Dust Collection Unit - Output',
    ),
  ];
  String searchTerm = '';

  void _deleteSensor(SensorData sensorToDelete) {
    setState(() {
      sensors
          .removeWhere((sensor) => sensor.sensorId == sensorToDelete.sensorId);
    });
  }

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
      body: Padding(
        padding: EdgeInsets.all(paddingval),
        child: Column(
          // Changed to Column
          children: [
            const Industryappbar(
              // Moved Industryappbar inside the Column
              showBackButton: true,
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Connected Sensors',
                style: TextStyle(fontSize: 25),
              ),
            ),
            const SizedBox(
              height: 10,
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
            Expanded(
              // Wrapped ListView.builder in Expanded
              child: filteredSensors.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Center(
                        child: Text(
                          'no sensor available',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: filteredSensors.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return SensorCard(
                          sensor: filteredSensors[index],
                          appRoute: AppRoutes.airlocationstats,
                          onDelete: () => _deleteSensor(filteredSensors[index]),
                        );
                      },
                    ),
            ),
            const SizedBox(
              height: 20,
            ),
            const GreenElevatedButton(
              // Added GreenElevatedButton
              text: "Connect New Sensor",
              navigateTo: AppRoutes.addsensor,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Industrynavbar(),
      // Removed floatingActionButton and floatingActionButtonLocation
    );
  }
}

class SensorCard extends StatelessWidget {
  final SensorData sensor;
  final String appRoute;
  final VoidCallback onDelete; // Added onDelete callback

  const SensorCard({
    super.key,
    required this.sensor,
    required this.appRoute,
    required this.onDelete, // Required onDelete callback
  });

  // Function to show the delete confirmation dialog
  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text(
            'Confirm Deletion',
            textAlign: TextAlign.center,
          ),
          content: const Column(
            // Use Column to arrange icon and text
            mainAxisSize: MainAxisSize.min, // Make column wrap its content
            children: [
              Icon(
                Icons.warning_amber_rounded, // Alert icon
                color: Colors.black, // Set color to black
                size: 60, // Set size to huge
              ),
              SizedBox(height: 10), // Spacing between icon and text
              Text(
                'Are you sure you want to remove the sensor?',
                textAlign: TextAlign.center, // Aligned content to center
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close the dialog
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close the dialog
                onDelete(); // Call the onDelete callback passed from parent
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Navigate to the specified route when the card is pressed
        Navigator.pushNamedAndRemoveUntil(
          context,
          appRoute,
          ModalRoute.withName(AppRoutes
              .sensorlist), // Assuming SensorListScreen is the "parent" for this navigation
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
            // Top row with Sensor ID and Delete Icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  sensor.sensorId, // Display sensor ID as main title
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline,
                      color: Colors.black), // Delete icon
                  onPressed: () {
                    _showDeleteConfirmationDialog(
                        context); // Show confirmation dialog on delete button press
                  },
                  padding: EdgeInsets.zero, // Remove default padding
                  constraints:
                      const BoxConstraints(), // Remove default constraints
                ),
              ],
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
                const Spacer(), // Pushes the Edit button to the right
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.addsensor,
                      arguments: sensor, // Pass the sensor data
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero, // Remove default padding
                    minimumSize: Size.zero, // Remove default minimum size
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Edit',
                    style: TextStyle(fontSize: 14, color: Colors.blue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
