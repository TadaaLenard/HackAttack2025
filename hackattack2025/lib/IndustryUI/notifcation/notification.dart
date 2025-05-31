import 'package:flutter/material.dart';
import 'package:hackattack2025/components/appbar.dart'; // Assuming this path is correct
import 'package:hackattack2025/components/navbar.dart';
import 'package:hackattack2025/datamodel.dart'; // Assuming this path is correct

class NotificationCard extends StatelessWidget {
  final RealTimeSensorRecord realTimeRecord;

  const NotificationCard({
    Key? key,
    required this.realTimeRecord,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine the color of the status indicator based on the status string.
    Color statusColor;
    switch (realTimeRecord.sensorStack.status.toLowerCase()) {
      case 'alert':
        statusColor = Colors.red; // Red for alerts
        break;
      case 'warning':
        statusColor = Colors.orange; // Orange for warnings
        break;
      case 'normal':
        statusColor = Colors.green; // Green for normal status
        break;
      default:
        statusColor = Colors.grey; // Default color for unknown status
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Notification title, e.g., "Air Monitoring Alert"
                Expanded(
                  child: Text(
                    '${realTimeRecord.sensorStack.stackName} Alert',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8.0),
                // Date and status indicator dot
                Row(
                  children: [
                    Text(
                      realTimeRecord
                          .date, // Dynamic date from RealTimeSensorRecord
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(width: 8.0),
                    // Status indicator dot
                    Container(
                      width: 10.0,
                      height: 10.0,
                      decoration: BoxDecoration(
                        color: statusColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            // Location and parameter breached details
            Text(
              'Location: ${realTimeRecord.sensorStack.lastReading}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'Parameter Breached: ${realTimeRecord.sensorStack.status}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8.0),
            // More details text
            Text(
              'More details available in the monitoring dashboard.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class Industrynoti extends StatefulWidget {
  const Industrynoti({
    super.key,
  });

  @override
  State<Industrynoti> createState() => _IndustrynotiState();
}

class _IndustrynotiState extends State<Industrynoti> {
  final paddingval = 20.0;

  // Dummy data for notifications, now using RealTimeSensorRecord
  final List<RealTimeSensorRecord> _notifications = [
    RealTimeSensorRecord(
      sensorStack: SensorStack(
        stackName: 'Air Monitoring',
        lastReading: 'Calcination Unit - Stack 2',
        status: 'Alert',
      ),
      date: 'May 22, 2025',
    ),
    RealTimeSensorRecord(
      sensorStack: SensorStack(
        stackName: 'Water Quality',
        lastReading: 'Treatment Plant - Outlet 1',
        status: 'Warning',
      ),
      date: 'May 21, 2025',
    ),
    RealTimeSensorRecord(
      sensorStack: SensorStack(
        stackName: 'Temperature Sensor',
        lastReading: 'Server Room - Rack 5',
        status: 'Normal',
      ),
      date: 'May 20, 2025',
    ),
    RealTimeSensorRecord(
      sensorStack: SensorStack(
        stackName: 'Noise Level',
        lastReading: 'Production Line A',
        status: 'Alert',
      ),
      date: 'May 19, 2025',
    ),
    RealTimeSensorRecord(
      sensorStack: SensorStack(
        stackName: 'Vibration Monitor',
        lastReading: 'Machine 3 - Bearing',
        status: 'Normal',
      ),
      date: 'May 18, 2025',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(paddingval),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Your existing app bar
                Industryappbar(showBackButton: true),
                SizedBox(height: 16.0), // Spacing below app bar
                Text(
                  'Notification',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Just now', // "Just now" text as seen in the image
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: paddingval),
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                return NotificationCard(
                  realTimeRecord: _notifications[
                      index], // Pass the new RealTimeSensorRecord object
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const Industrynavbar(),
    );
  }
}
