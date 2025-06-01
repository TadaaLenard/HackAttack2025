import 'package:flutter/material.dart';
import 'package:hackattack2025/IndustryUI/homepage/airmonitor/airlocationlist.dart';
import 'package:hackattack2025/components/appbar.dart';
import 'package:hackattack2025/components/customizedbutton.dart';
import 'package:hackattack2025/components/navbar.dart';
import 'package:hackattack2025/datamodel.dart';
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
      scheduleType: 'Weekly Equipment Cleaning',
      scheduleDate: '30/05/2025',
      location: 'Coking Unit 1 – Heat Exchanger Bay',
      notes:
          'Standard weekly cleaning of heat exchanger surfaces.', // Added notes
    ),
    const ScheduleData(
      scheduleType: 'Monthly Machine Maintenance',
      scheduleDate: '01/06/2025',
      location: 'Refinery Section 3 - Pump Station',
      notes:
          'Includes lubrication and filter checks for all pumps.', // Added notes
    ),
    const ScheduleData(
      scheduleType: 'Quarterly Safety Inspection',
      scheduleDate: '05/06/2025',
      location: 'Storage Tank Farm - Tank 12',
      notes:
          'Review of safety protocols and emergency equipment.', // Added notes
    ),
    const ScheduleData(
      scheduleType: 'Instrument Calibration',
      scheduleDate: '10/06/2025',
      location: 'Control Room - Panel A',
      notes: 'Calibration of pressure and temperature sensors.', // Added notes
    ),
    const ScheduleData(
      scheduleType: 'Emergency Repair',
      scheduleDate: '15/06/2025',
      location: 'Distillation Column - Section 2',
      notes:
          'Repair of minor leak in pipe connection. Requires shut down.', // Added notes
    ),
  ];
  String searchTerm = '';

  void _deleteSchedule(ScheduleData scheduleToDelete) {
    setState(() {
      schedules.removeWhere(
          (schedule) => schedule.scheduleType == scheduleToDelete.scheduleType);
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
                .contains(searchTerm.toLowerCase()) ||
            (schedule.notes != null &&
                schedule.notes!.toLowerCase().contains(
                    searchTerm.toLowerCase()))) // Include notes in search
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
                'Maintenance Schedules', // Changed title to 'Schedules'
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
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: Colors.black,
                size: 60,
              ),
              SizedBox(height: 10),
              Text(
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
          context,
          AppRoutes.scheduleinfo,
          arguments: schedule,
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
                // "More" button on the left
                Icon(Icons.location_on, size: 16, color: Colors.grey[700]),
                const SizedBox(width: 4),
                Text(
                  schedule.location, // Display location
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              ],
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    // Handle "More" button press
                    // This could navigate to a detailed schedule view
                    Navigator.pushNamed(
                      context,
                      AppRoutes.scheduleinfo,
                      arguments: schedule,
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'More',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const Spacer(), // Pushes the Edit button to the right
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.addschedule,
                      arguments: schedule,
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Edit',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
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
