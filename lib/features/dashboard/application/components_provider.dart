import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_home/features/dashboard/domain/component.dart';
import 'package:smart_home/features/devices/application/devices_notifier.dart';
import 'package:smart_home/features/devices/domain/device.dart';
import 'package:smart_home/features/rooms/application/rooms_provider.dart';
import 'package:smart_home/features/rooms/domain/room.dart';

part 'components_provider.g.dart';

// @riverpod
// Future<List<Component>> components(Ref ref) async {
//   final devices = await ref.watch(devicesNotifierProvider.future);
//   final components = [for (Device d in devices) ...d.components];
//   debugPrint(
//     'log: components: ${[for (var element in components) element.id]}',
//   );
//
//   return components;
// }

@riverpod
Future<Map<Room?, List<Component>>> componentsByRoom(Ref ref) async {
  final devices = await ref.watch(devicesProvider.future);
  final List<Component> components = [
    for (Device d in devices) ...d.components,
  ];
  final Map<int, Room> rooms = await ref.watch(roomsProvider.future);
  final Map<Room?, List<Component>> componentsByRoom = {};
  for (Component c in components) {
    final Room? room = rooms[c.roomId];
    (componentsByRoom[room] ??= []).add(c);
  }
  debugPrint('LOG: Components By Room: $componentsByRoom');
  return componentsByRoom;
}
