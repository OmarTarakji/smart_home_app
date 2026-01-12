import 'package:intl/intl.dart';

import '../../dashboard/models/component.dart';
import '../../dashboard/models/component_type.dart';

class Device {
  final String macAddress;
  final String type;
  final String? name;
  List<Component> components;
  final String? roomId;
  final DateTime createdAt;

  Device({
    required this.macAddress,
    required this.type,
    this.name,
    required this.components,
    this.roomId,
    required this.createdAt,
  });

  Device.fromJson(Map<String, dynamic> json)
    : macAddress = json['mac_address'],
      type = json['device_type'],
      name = json['name'],
      roomId = json['room_id'],
      createdAt = DateTime.parse(json['created_at']).toLocal(),
      components = (json['components'] as List)
          .map<Component>(
            (com) => Component.fromJson(
              com,
              (json['name'] as String?)?.isEmpty ?? true
                  ? json['device_type']
                  : json['name'],
              json['mac_address'],
            ),
          )
          .toList();

  Device copyWith({String? name, List<Component>? components, String? roomId}) {
    return Device(
      macAddress: macAddress,
      type: type,
      name: name ?? this.name,
      components: components ?? this.components,
      roomId: roomId ?? this.roomId,
      createdAt: createdAt,
    );
  }

  List<Component> get sensors =>
      components.where((c) => c.comType.type == CSType.sensor).toList();

  List<Component> get controls {
    return components.where((c) => c.comType.type == CSType.control).toList();
  }

  String getFormattedDateTime() {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(createdAt);
  }
}
