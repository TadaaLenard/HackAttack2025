import 'package:flutter/material.dart';
import 'package:hackattack2025/IndustryUI/homepage/airmonitor/airlocationlist.dart'; // This import might be unused now
import 'package:hackattack2025/components/appbar.dart';
import 'package:hackattack2025/components/customizedbutton.dart';
import 'package:hackattack2025/components/navbar.dart';
import 'package:hackattack2025/datamodel.dart'; // Assuming this file contains SensorData, will be updated to ScheduleData
import 'package:hackattack2025/navigation/route.dart';

class Schedulelist extends StatefulWidget {
  const Schedulelist({super.key});

  @override
  State<Schedulelist> createState() => _SchedulelistState();
}

class _SchedulelistState extends State<Schedulelist> {
  final paddingval = 20.0;
  final TextEditingController _searchController = TextEditingController();

  // Updated dummy data to match the new ScheduleData model and image
  List<ScheduleData> schedules = [
    const ScheduleData(
      scheduleId: 'CLEAN-20250530-001', // Internal ID
      scheduleType: 'Weekly Equipment Cleaning',
      scheduleDate: '30/05/2025',
      location: 'Coking Unit 1 – Heat Exchanger Bay',
    ),
    // You can add more dummy ScheduleData objects here if needed
    const ScheduleData(
      scheduleId: 'MAINT-20250601-002',
      scheduleType: 'Monthly Machine Maintenance',
      scheduleDate: '01/06/2025',
      location: 'Refinery Section 3 - Pump Station',
    ),
    const ScheduleData(
      scheduleId: 'INSP-20250605-003',
      scheduleType: 'Quarterly Safety Inspection',
      scheduleDate: '05/06/2025',
      location: 'Storage Tank Farm - Tank 12',
    ),
  ];
  String searchTerm = '';

  void _deleteSchedule(ScheduleData scheduleToDelete) {
    setState(() {
      schedules.removeWhere(
          (schedule) => schedule.scheduleId == scheduleToDelete.scheduleId);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredSchedules = schedules
        .where((schedule) =>
            schedule.scheduleType
                .toLowerCase()
                .contains(searchTerm.toLowerCase()) ||
            schedule.location
                .toLowerCase()
                .contains(searchTerm.toLowerCase()) ||
            schedule.scheduleDate
                .toLowerCase()
                .contains(searchTerm.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(paddingval),
        child: Column(
          children: [
            const Industryappbar(
              showBackButton: true,
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Schedules', // Changed title to 'Schedules'
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
              child: filteredSchedules.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Center(
                        child: Text(
                          'No schedules available', // Changed text
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: filteredSchedules.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ScheduleCard(
                          schedule:
                              filteredSchedules[index], // Changed variable name
                          appRoute: AppRoutes
                              .airlocationstats, // This route might need adjustment based on schedule details
                          onDelete: () =>
                              _deleteSchedule(filteredSchedules[index]),
                        );
                      },
                    ),
            ),
            const SizedBox(
              height: 20,
            ),
            const GreenElevatedButton(
              text: "Create New Schedule", // Changed button text
              navigateTo: AppRoutes
                  .addsensor, // This route might need to be adjusted for 'add schedule'
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Industrynavbar(),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  final ScheduleData schedule; // Changed variable name to 'schedule'
  final String appRoute;
  final VoidCallback onDelete;

  const ScheduleCard({
    super.key,
    required this.schedule, // Changed variable name
    required this.appRoute,
    required this.onDelete,
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
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.warning_amber_rounded,
                color: Colors.black,
                size: 60,
              ),
              const SizedBox(height: 10),
              const Text(
                'Are you sure you want to remove this schedule?', // Changed text
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                onDelete();
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
        Navigator.pushNamed(
          // Changed from pushNamedAndRemoveUntil as it's typically for navigating to a new root
          context,
          appRoute,
          arguments: schedule, // Pass the schedule data
        );
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        elevation: 0,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row with Schedule Type and Delete Icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  schedule.scheduleType, // Display schedule type as main title
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.black),
                  onPressed: () {
                    _showDeleteConfirmationDialog(context);
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              "Date: ${schedule.scheduleDate}", // Display schedule date
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.location_on, size: 16, color: Colors.grey[700]),
                const SizedBox(width: 4),
                Text(
                  schedule.location, // Display location
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes
                          .addsensor, // This route needs to be adjusted for 'edit schedule'
                      arguments: schedule, // Pass the schedule data
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
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

// Assuming SearchBarWidget is defined elsewhere and works with TextEditingController
// Assuming Industryappbar, GreenElevatedButton, Industrynavbar, and AppRoutes are defined elsewhere.