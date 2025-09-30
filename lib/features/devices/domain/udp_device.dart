import 'package:smart_home/features/dashboard/domain/component.dart';
import 'package:smart_home/features/dashboard/domain/component_type.dart';

class UdpDevice {
  final String ipAddress;
  final String macAddress;
  final String type;
  List<Component> components;

  UdpDevice(this.ipAddress, this.macAddress, this.type, this.components);

  UdpDevice.fromJson(Map<String, dynamic> json, this.ipAddress)
    : type = json['device_type'],
      macAddress = json['mac_address'],
      components = [
        for (int i = 0; i < json['components'].length; i++)
          Component(
            id: i,
            comType: ComponentType.from(json['components'][i]),
            deviceInfo: '',
            mac: json['mac_address'],
          ),
      ];

  List<Component> get sensors =>
      components.where((c) => c.comType.type == CSType.sensor).toList();

  List<Component> get controls {
    return components.where((c) => c.comType.type == CSType.control).toList();
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'p_mac_address': macAddress,
    'p_device_type': type,
    'p_components': components.map((com) => com.toJson()).toList(),
  };

  @override
  String toString() {
    return 'UdpDevice{ipAddress: $ipAddress, macAddress: $macAddress, type: $type, Number of components: ${components.length}';
  }
}
