import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_home/core/utils/exceptions.dart';

import '../../../devices/application/devices_notifier.dart';
import '../../../devices/domain/device.dart';
import '../../models/component.dart';

part 'component_provider.g.dart';

@riverpod
Future<Component> component(Ref ref, int id) async {
  final devices = await ref.watch(devicesProvider.future);
  for (Device d in devices) {
    final index = d.components.indexWhere((c) => c.id == id);
    if (index != -1) {
      debugPrint("Selecting component: ${d.components[index].comType}");
      debugPrint("Index: ${index}");

      return d.components[index];
    }
  }
  debugPrint("Component not found.");

  throw const DeviceException("Component not found");
}
