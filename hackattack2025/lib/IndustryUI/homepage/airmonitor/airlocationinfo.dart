import 'package:flutter/material.dart';
import 'package:hackattack2025/datamodel.dart';
import 'package:hackattack2025/navigation/route.dart';

class Locationcontent extends StatefulWidget {
  const Locationcontent({super.key});

  @override
  State<Locationcontent> createState() => _LocationcontentState();
}

class _LocationcontentState extends State<Locationcontent> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CalcinationUnitWidget(),
        ScheduleWidget(),
      ],
    );
  }
}

class CalcinationUnitWidget extends StatelessWidget {
  const CalcinationUnitWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30, bottom: 30),
      width: 350, // Adjust width as needed
      decoration: BoxDecoration(
        color: Colors.white, // Card background color
        borderRadius:
            BorderRadius.circular(12), // Rounded corners for the entire card
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4), // Shadow color
            spreadRadius: 0, // No spreading of the shadow
            blurRadius: 10, // Blurring to make it soft
            offset: const Offset(
                0, 8), // Shifts the shadow only downwards (positive Y)
          ),
          // You can add another subtle shadow for a slight overall lift if desired
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1), // A very slight shadow for top/sides
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // To wrap content
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Warning Section
          Container(
            height: 80, // Height of the warning section
            decoration: const BoxDecoration(
                // No radius here, as the outer container handles the overall card shape
                // but we need to match the top curvature if it was a standalone component.
                // Since the outer container has the radius, this will naturally fit.
                ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          Colors.amber[800], // Darker yellow for the icon side
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(
                            12), // Match the outer container's top-left radius
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.waves, // Similar to the squiggly lines
                        size: 48,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors
                          .amber[600], // Lighter yellow for the warning text
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(
                            12), // Match the outer container's top-right radius
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Warning',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Pollution Readings Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildPollutionReading('PM2.5', 24, Colors.orange),
                _buildPollutionReading('PM10', 8, Colors.grey),
                _buildPollutionReading('CO2', 24, Colors.grey),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPollutionReading(String label, int value, Color color) {
    return Column(
      children: [
        Text(
          '$label - $value',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}

class ScheduleWidget extends StatefulWidget {
  const ScheduleWidget({super.key});

  @override
  State<ScheduleWidget> createState() => _ScheduleWidgetState();
}

class _ScheduleWidgetState extends State<ScheduleWidget> {
  int _selectedDayIndex = 0;

  // Mock Data for the schedule
  final List<DaySchedule> _scheduleData = [
    DaySchedule(
      dayName: 'Wednesday',
      timeSlots: [
        TimeSlot(time: '9:00 am', status: 'Normal'),
        TimeSlot(time: '10:00 am', status: 'Warning'),
        TimeSlot(time: '11:00 am', status: 'Warning'),
        TimeSlot(time: '12:00 pm', status: 'No data'),
        TimeSlot(time: '1:00 pm', status: 'No data'),
        TimeSlot(time: '2:00 pm', status: 'No data'),
      ],
      sensorReadings: [
        SensorReading(type: 'PM2.5', unit: 'µg/m³', value: 24),
        SensorReading(type: 'PM10', unit: 'µg/m³', value: 10),
        SensorReading(type: 'CO2', unit: 'µg/m³', value: 3000),
        SensorReading(type: 'SO2', unit: 'µg/m³', value: 5),
      ],
      recommendations: [
        Recommendation(
            text:
                'Implement continuous emission monitoring systems and smart air quality sensors for real-time tracking.'),
        Recommendation(
            text:
                'Optimize furnace and coking operations for maximum combustion efficiency and minimal fugitive emissions.'),
        Recommendation(text: 'Regularly maintain baghouses, scrubbers.'),
      ],
    ),
    DaySchedule(
      dayName: 'Thursday',
      timeSlots: [
        TimeSlot(time: '9:00 am', status: 'No data'),
        TimeSlot(time: '10:00 am', status: 'Normal'),
        TimeSlot(time: '11:00 am', status: 'Normal'),
        TimeSlot(time: '12:00 pm', status: 'Warning'),
        TimeSlot(time: '1:00 pm', status: 'Warning'),
        TimeSlot(time: '2:00 pm', status: 'No data'),
      ],
      sensorReadings: [
        SensorReading(type: 'PM2.5', unit: 'µg/m³', value: 18),
        SensorReading(type: 'PM10', unit: 'µg/m³', value: 8),
        SensorReading(type: 'CO2', unit: 'µg/m³', value: 2800),
        SensorReading(type: 'SO2', unit: 'µg/m³', value: 4),
      ],
      recommendations: [
        Recommendation(
            text:
                'Continue monitoring and consider further optimization of processes.'),
        Recommendation(text: 'Review air filtration systems regularly.'),
      ],
    ),
    DaySchedule(
      dayName: 'Friday',
      timeSlots: [
        TimeSlot(time: '9:00 am', status: 'Warning'),
        TimeSlot(time: '10:00 am', status: 'No data'),
        TimeSlot(time: '11:00 am', status: 'Normal'),
      ],
      sensorReadings: [
        SensorReading(type: 'PM2.5', unit: 'µg/m³', value: 12),
        SensorReading(type: 'PM10', unit: 'µg/m³', value: 6),
        SensorReading(type: 'CO2', unit: 'µg/m³', value: 2500),
        SensorReading(type: 'SO2', unit: 'µg/m³', value: 3),
      ],
      recommendations: [
        Recommendation(text: 'Maintain current operational practices.'),
        Recommendation(
            text: 'Conduct weekly checks on all monitoring equipment.'),
      ],
    ),
    DaySchedule(
      dayName: 'Saturday',
      timeSlots: [
        TimeSlot(time: '9:00 am', status: 'No data'),
        TimeSlot(time: '10:00 am', status: 'Normal'),
        TimeSlot(time: '11:00 am', status: 'Normal'),
        TimeSlot(time: '12:00 pm', status: 'Warning'),
        TimeSlot(time: '1:00 pm', status: 'Warning'),
        TimeSlot(time: '2:00 pm', status: 'No data'),
      ],
      sensorReadings: [
        SensorReading(type: 'PM2.5', unit: 'µg/m³', value: 15),
        SensorReading(type: 'PM10', unit: 'µg/m³', value: 7),
        SensorReading(type: 'CO2', unit: 'µg/m³', value: 2600),
        SensorReading(type: 'SO2', unit: 'µg/m³', value: 2),
      ],
      recommendations: [
        Recommendation(
            text: 'Review weekend operations for potential improvements.'),
        Recommendation(
            text:
                'Ensure all systems are functioning optimally during off-peak hours.'),
      ],
    ),
  ];

  // Helper method to get background color based on status
  Color _getBackgroundColor(String status) {
    return status == 'Normal'
        ? Colors.green
        : status == 'Warning'
            ? Colors.amber[400]!
            : Colors.transparent; // For 'No data'
  }

  // Helper method to get text color based on status
  Color _getTextColor(String status) {
    return status == 'Normal'
        ? Colors.white
        : status == 'Warning'
            ? Colors.black
            : Colors.black54; // For 'No data'
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Day Tabs Section (Scrollable)
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(_scheduleData.length, (index) {
              final day = _scheduleData[index];
              final isSelected = index == _selectedDayIndex;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedDayIndex = index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            day.dayName,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: isSelected
                                  ? Colors.black87
                                  : Colors.grey[600],
                            ),
                          ),
                          // The yellow dot is now conditionally rendered based on selection
                          if (isSelected) ...[
                            const SizedBox(width: 6),
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Colors.amber, // Yellow dot
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Underline for selected day
                      Container(
                        height: 3,
                        // Adjust width based on text length and whether the dot is present
                        width:
                            day.dayName.length * 10.0 + (isSelected ? 15 : 0),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.teal[700]
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
        // Grey light line below the day tabs
        Padding(
          padding: const EdgeInsets.only(top: 8.0), // Adjust spacing as needed
          child: Container(
            height: 1.0, // Thickness of the line
            color: Colors.grey[300], // Light grey color
          ),
        ),
        const SizedBox(height: 20), // Spacing between line and time details

        // Time Details Section (Scrollable)
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _scheduleData[_selectedDayIndex].timeSlots.map((slot) {
              final Color slotBackgroundColor =
                  _getBackgroundColor(slot.status);
              final Color slotTextColor = _getTextColor(slot.status);

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      slot.time,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: slotBackgroundColor,
                        borderRadius: BorderRadius.circular(20),
                        border: slot.status == 'No data'
                            ? Border.all(color: Colors.transparent)
                            : null,
                      ),
                      child: Text(
                        slot.status,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: slotTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 15),

        // More details TextButton
        Align(
          alignment: Alignment.center,
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.airlocationdetails,
                  arguments: _scheduleData);
            },
            style: TextButton.styleFrom(
              textStyle: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                decoration: TextDecoration.underline, // Apply underline here
              ),
              foregroundColor: Colors.black, // Ensures the text color is black
            ),
            child: const Text(
              'More details',
            ),
          ),
        ),
      ],
    );
  }
}
