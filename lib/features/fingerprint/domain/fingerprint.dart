class Fingerprint {
  final int id;
  final int sensorFingerprintId;
  final int sensorId;
  final String name;

  const Fingerprint(
    this.id,
    this.sensorFingerprintId,
    this.sensorId,
    this.name,
  );

  factory Fingerprint.fromJson(Map<String, dynamic> json) {
    return Fingerprint(
      json['id'],
      json['fingerprint_id'],
      json['sensor_id'],
      json['name'],
    );
  }

  Fingerprint copyWith({required String name}) {
    return Fingerprint(id, sensorFingerprintId, sensorId, name);
  }
}

class FingerprintScan {
  final String name;
  final DateTime timeScanned;

  const FingerprintScan(this.name, this.timeScanned);

  FingerprintScan.fromJson(Map<String, dynamic> json)
    : name = json['fingerprint_name'],
      timeScanned = DateTime.parse(json['access_time']).toLocal();

  @override
  String toString() => '$name scanned at $timeScanned';
}
