import 'package:smart_home/features/dashboard/domain/component.dart';
import 'package:smart_home/features/devices/domain/device.dart';

class FilteredComponents {
  final int roomId;
  final List<Component> added;
  final List<Component> available;
  final List<Component> unavailable;

  FilteredComponents({required this.roomId, required List<Device> devices})
    : added = [],
      available = [],
      unavailable = [] {
    for (Device d in devices) {
      for (Component c in d.components) {
        // Already added
        if (c.roomId == roomId) {
          added.add(c);
        }
        // Not assigned a room
        else if (c.roomId == null) {
          available.add(c);
        }
        // Assigned a different room
        else {
          unavailable.add(c);
        }
      }
    }
  }

  const FilteredComponents._(
    this.roomId,
    this.added,
    this.available,
    this.unavailable,
  );

  /// Return a copy where the component is not assigned a room
  FilteredComponents removeComponent(Component com) {
    added.remove(com);
    available.add(com);
    return FilteredComponents._(roomId, added, available, unavailable);
  }

  /// Return a copy where the component is assigned to this room
  FilteredComponents addComponent(Component com) {
    if (available.contains(com)) {
      available.remove(com);
      added.add(com);
    } else {
      unavailable.remove(com);
      added.add(com);
    }
    return FilteredComponents._(roomId, added, available, unavailable);
  }

  bool get isEmpty => available.isEmpty && added.isEmpty && unavailable.isEmpty;
}
