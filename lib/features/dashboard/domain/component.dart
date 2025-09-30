import 'component_type.dart';

class Component {
  final int id;
  final ComponentType comType;
  final String? name;
  final String image;
  final int? roomId;
  final String mac;
  final String deviceInfo;

  Component({
    required this.id,
    required this.comType,
    this.name,
    String? image,
    this.roomId,
    required this.deviceInfo,
    required this.mac,
  }) : image = image ?? comType.defaultImage;

  //Custom constructor for Supabase response
  Component.fromJson(Map<String, dynamic> json, this.deviceInfo, this.mac)
    : id = json['id'],
      name = json['name'],
      roomId = json['room_id'],
      comType = ComponentType.from(json['component_type']),
      image =
          json['image'] ??
          ComponentType.from(json['component_type']).defaultImage;

  Map<String, dynamic> toJson() => {
    'component_id': id,
    'name': name,
    'image': image,
    'room_id': roomId,
    'component_type': comType.name,
  };

  @override
  String toString() {
    return 'Component(id: $id, comType: $comType, name: $name, roomId: $roomId)';
  }

  Component copyWithRoom(int? roomId) {
    return Component(
      id: id,
      comType: comType,
      name: name,
      roomId: roomId,
      deviceInfo: deviceInfo,
      mac: mac,
    );
  }
}
