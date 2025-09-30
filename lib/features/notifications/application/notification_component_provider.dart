import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_home/features/dashboard/domain/component.dart';
import 'package:smart_home/features/devices/application/devices_notifier.dart';

part 'notification_component_provider.g.dart';

@riverpod
Component? notificationComponent(Ref ref, int? componentId) {
  if (componentId != null) {
    final components = ref
        .watch(devicesProvider)
        .asData
        ?.value
        .expand((device) => device.components);
    if (components != null) {
      for (final c in components) {
        if (c.id == componentId) return c;
      }
    }
  }
  return null;
}
