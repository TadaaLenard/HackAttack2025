import 'package:flutter/material.dart';
import 'package:hackattack2025/components/appbar.dart';
import 'package:hackattack2025/components/customizedbutton.dart';
import 'package:hackattack2025/components/navbar.dart';
import 'package:hackattack2025/datamodel.dart';
import 'package:hackattack2025/navigation/route.dart';

class DayScheduleWidget extends StatefulWidget {
  final List<DaySchedule> daySchedules;

  const DayScheduleWidget({super.key, required this.daySchedules});

  @override
  _DayScheduleWidgetState createState() => _DayScheduleWidgetState();
}

class _DayScheduleWidgetState extends State<DayScheduleWidget> {
  // State to manage the currently selected day
  int _selectedDayIndex = 0;
  // State to manage the currently selected time slot within the day
  int _selectedTimeSlotIndex =
      0; // Initialize to 0 or a default highlight if needed

  // Helper function to determine the color based on sensor type and value
  Color _getIndicatorColor(SensorReading reading) {
    switch (reading.type) {
      case 'PM2.5':
        // Based on the image, PM2.5 is red if value is 24, green otherwise.
        // Let's assume a threshold, e.g., > 20 is red.
        return reading.value > 20 ? Colors.red : Colors.green;
      case 'PM10':
      case 'CO2':
      case 'SO2':
        // These are consistently green in the provided image
        return Colors.green;
      default:
        return Colors.grey; // Default color for unknown types
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the currently selected day's data
    // Ensure daySchedules is not empty before accessing _selectedDayIndex
    final DaySchedule currentDaySchedule = widget.daySchedules.isNotEmpty
        ? widget.daySchedules[_selectedDayIndex]
        : DaySchedule(
            dayName: 'N/A',
            timeSlots: [],
            sensorReadings: [],
            recommendations: [],
          ); // Provide a fallback empty schedule

    return Column(
      // Changed from Scaffold to Column to be embedded
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Day Tabs (Wednesday, Thursday, Friday)
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: widget.daySchedules.asMap().entries.map((entry) {
              int idx = entry.key;
              DaySchedule day = entry.value;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedDayIndex = idx;
                    // Reset selected time slot when day changes, or keep it if desired
                    _selectedTimeSlotIndex = 0;
                  });
                },
                child: Column(
                  children: [
                    Text(
                      day.dayName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _selectedDayIndex == idx
                            ? Colors.black
                            : Colors.grey,
                      ),
                    ),
                    if (_selectedDayIndex == idx)
                      Container(
                        margin: const EdgeInsets.only(top: 4.0),
                        height: 3.0,
                        width: 40.0,
                        color: Colors.orange, // Indicator for selected day
                      ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        // Time Slots
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: currentDaySchedule.timeSlots.asMap().entries.map((entry) {
              int idx = entry.key;
              TimeSlot timeSlot = entry.value;
              // Wrap Text with Expanded and GestureDetector to make it clickable
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTimeSlotIndex = idx;
                    });
                  },
                  child: Text(
                    timeSlot.time,
                    textAlign: TextAlign
                        .center, // Center the text within its expanded space
                    style: TextStyle(
                      fontSize: 12.0,
                      // Highlight the selected time slot
                      color: _selectedTimeSlotIndex == idx
                          ? Colors.black
                          : Colors.grey[600],
                      fontWeight: _selectedTimeSlotIndex == idx
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        // Separator Line
        Container(
          height: 1.0,
          color: Colors.grey[200],
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Sensor Readings Section
              const Text(
                'Sensor readings',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 2.5,
                ),
                itemCount: currentDaySchedule.sensorReadings.length,
                itemBuilder: (context, index) {
                  final reading = currentDaySchedule.sensorReadings[index];
                  // Determine color using the helper function
                  final indicatorColor = _getIndicatorColor(reading);

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 10.0,
                        height: 10.0,
                        decoration: BoxDecoration(
                          color:
                              indicatorColor, // Use the dynamically determined color
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${reading.type} ${reading.unit}',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey[700],
                            ),
                          ),
                          Text(
                            reading.value.toString(),
                            style: const TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              // Reduced SizedBox height here
              const SizedBox(height: 24.0),

              // Recommendations Section
              const Text(
                'Recommendations',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: currentDaySchedule.recommendations.map((rec) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '• ',
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                        ),
                        Expanded(
                          child: Text(
                            rec.text,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey[800],
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Locationdetails extends StatefulWidget {
  final List<DaySchedule> dummySchedules;
  const Locationdetails({super.key, required this.dummySchedules});

  @override
  State<Locationdetails> createState() => _LocationdetailsState();
}

class _LocationdetailsState extends State<Locationdetails> {
  final paddingval = 20.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(paddingval),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Industryappbar(showBackButton: true),
                        const SizedBox(height: 10),
                        // Pass the dummySchedules to DayScheduleWidget
                        DayScheduleWidget(daySchedules: widget.dummySchedules),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: paddingval, vertical: 10),
            color: Colors.white,
            child: const SizedBox(
                width: double.infinity,
                child: GreenElevatedButton(
                    text: 'Ask Personalised Chatbot',
                    navigateTo: AppRoutes.airlocationdetails)),
          ),
        ],
      ),
      bottomNavigationBar: const Industrynavbar(),
    );
  }
}
