import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';
import 'package:smart_home/core/utils/text_formatter.dart';
import 'package:smart_home/features/dashboard/models/component.dart';
import 'package:smart_home/features/rooms/data/rooms_repository.dart';

import '../../devices/application/devices_notifier.dart';
import '../../devices/domain/device.dart';
import '../domain/filtered_component.dart';
import '../presentation/controllers/running_operations_providers.dart';

part 'room_providers.g.dart';

@riverpod
Future<List<Component>> roomComponents(Ref ref, int roomId) async {
  final devices = await ref.watch(devicesProvider.future);

  //return components filtered by roomId:
  final List<Component> roomComponents = [];
  for (Device d in devices) {
    for (Component c in d.components) {
      if (c.roomId == roomId) roomComponents.add(c);
    }
  }

  return roomComponents;
}

@riverpod
class FilteredComponentsNotifier extends _$FilteredComponentsNotifier {
  final _repo = RoomsRepository();

  @override
  Future<FilteredComponents> build(int roomId) async {
    final devices = await ref.read(devicesProvider.future);

    //return components filtered by roomId:
    return FilteredComponents(roomId: roomId, devices: devices);
  }

  Future<String?> addComponent(
    Component component,
    AppLocalizations l10n,
  ) async {
    state = AsyncData(state.requireValue.addComponent(component));
    ref.read(runningOperationsProvider.notifier).increment();
    try {
      // Update Database
      await _repo.addComponentToRoom(component.id, roomId);
      //Update Devices Notifier
      ref.read(devicesProvider.notifier).assignRoom(component.id, roomId);
    } catch (error) {
      state = AsyncData(state.requireValue.removeComponent(component));
      return 'Failed to add room, ${TextFormatter.getErrorMessage(error, l10n)}';
    } finally {
      ref.read(runningOperationsProvider.notifier).decrement();
    }
    return null;
  }

  Future<String?> removeComponent(
    Component component,
    AppLocalizations l10n,
  ) async {
    state = AsyncData(state.requireValue.removeComponent(component));
    ref.read(runningOperationsProvider.notifier).increment();
    try {
      // Update Database
      await _repo.addComponentToRoom(component.id, null);
      //Update Devices Notifier
      ref.read(devicesProvider.notifier).assignRoom(component.id, null);
    } catch (error) {
      state = AsyncData(state.requireValue.addComponent(component));
      return 'Failed to remove room, ${TextFormatter.getErrorMessage(error, l10n)}';
    } finally {
      ref.read(runningOperationsProvider.notifier).decrement();
    }
    return null;
  }
}
