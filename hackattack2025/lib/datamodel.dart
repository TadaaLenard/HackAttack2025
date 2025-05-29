class SensorStack {
  final String stackName;
  final String lastReading;
  final String status;

  SensorStack({
    required this.stackName,
    required this.lastReading,
    required this.status,
  });
}

// Data models for our schedule
class TimeSlot {
  final String time;
  final String status; // Status will determine the colors

  TimeSlot({
    required this.time,
    required this.status,
  });
}

/// Represents a single sensor reading.
class SensorReading {
  final String type;
  final String unit;
  final int value;

  SensorReading({
    required this.type,
    required this.unit,
    required this.value,
  });
}

/// Represents a recommendation.
class Recommendation {
  final String text;

  Recommendation({required this.text});
}

/// Represents the schedule for a specific day.
class DaySchedule {
  final String dayName;
  final List<TimeSlot> timeSlots;
  final List<SensorReading> sensorReadings;
  final List<Recommendation> recommendations;
  // Removed 'isSelected' from here

  DaySchedule({
    required this.dayName,
    required this.timeSlots,
    required this.sensorReadings,
    required this.recommendations,
  });
}

class SensorData {
  final String sensorId;
  final String sensorType;
  final String lastReading;
  final String location;
  final String? installationDate;

  const SensorData({
    required this.sensorId,
    required this.sensorType,
    required this.lastReading,
    required this.location,
    this.installationDate,
  });
}

class ScheduleData {
  final String scheduleId;
  final String scheduleType;
  final String scheduleDate; // New field for the date
  final String location;

  const ScheduleData({
    required this.scheduleId,
    required this.scheduleType,
    required this.scheduleDate,
    required this.location,
  });
}
