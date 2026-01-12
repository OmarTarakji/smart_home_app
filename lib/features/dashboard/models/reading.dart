class ComponentReading {
  final DateTime timestamp;
  final String value;
  final bool isLoading;

  ComponentReading({required this.timestamp, required this.value})
    : isLoading = false;

  ComponentReading.loading()
    : isLoading = true,
      timestamp = DateTime(2025),
      value = '';

  ComponentReading.fromJson(Map<String, dynamic> json)
    : value = json['value'],
      timestamp = DateTime.parse(json['timestamp']).toLocal(),
      isLoading = false;

  @override
  String toString() {
    return 'ComponentReading(timestamp: $timestamp, value: $value)';
  }
}

class ComponentReadings {
  final Map<int, ComponentReading?> data;
  final bool isLoading;

  ComponentReadings(this.data) : isLoading = false;
  ComponentReadings.loading() : data = {}, isLoading = true;

  ComponentReadings copyWith(int id, ComponentReading reading) {
    final newData = Map<int, ComponentReading?>.from(data);
    newData[id] = reading;
    return ComponentReadings(newData);
  }
}

class AvgComponentReading {
  final double value;
  final int readingCount;
  final DateTime timestamp;

  AvgComponentReading(this.value, this.readingCount, this.timestamp);

  AvgComponentReading.fromJson(Map<String, dynamic> json)
    : value = json['avg_value'],
      readingCount = json['reading_count'],
      timestamp = DateTime.parse(json['interval_start']).toLocal();

  @override
  String toString() {
    return 'Reading(value: $value, timestamp: $timestamp)';
  }

  double get minute => timestamp.minute + (timestamp.hour * 60).toDouble();
}

class ComponentReadingCount {
  final int value;
  final DateTime timestamp;

  ComponentReadingCount(this.value, this.timestamp);

  ComponentReadingCount.fromJson(Map<String, dynamic> json)
    : value = json['record_count'] ?? 0,
      timestamp = DateTime.parse(json['interval_start']).toLocal();

  @override
  String toString() {
    return 'Reading(value: $value, timestamp: $timestamp)';
  }

  double get minute => timestamp.minute + (timestamp.hour * 60).toDouble();
}
