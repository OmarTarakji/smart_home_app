import 'package:flutter/foundation.dart' show debugPrint;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_home/core/constants/demo_account.dart';
import 'package:smart_home/core/utils/exceptions.dart';
import 'package:smart_home/features/devices/application/udp_service_provider.dart';
import 'package:smart_home/features/devices/data/devices_repository.dart';
import 'package:smart_home/features/devices/domain/device.dart';

import '../domain/udp_device.dart';

part 'devices_notifier.g.dart';

@riverpod
DevicesRepository devicesRepository(Ref ref) => DevicesRepository();

@riverpod
class DevicesNotifier extends _$DevicesNotifier {
  late final _repo = ref.watch(devicesRepositoryProvider);

  @override
  FutureOr<List<Device>> build() async {
    ref.keepAlive();
    try {
      // Fetch devices list
      final devices = await _repo.getUserDevices();
      debugPrint('log: built Devices Notifier');
      return devices;
    } catch (e) {
      // Start auto-reload if initial load fails
      debugPrint('log: Error linking device: $e');
      debugPrint('log: Failed to load Devices, starting auto-reload');
      _autoReload();
      rethrow;
    }
  }

  void _autoReload() async {
    while (true) {
      try {
        debugPrint('log: Loading devices...');
        final profile = await _repo.getUserDevices();
        state = AsyncData(profile);
        break;
      } catch (e) {
        debugPrint('log: Error linking device: $e');
        debugPrint('log: Error loading devices, Scheduling for auto-reload');
        await Future.delayed(const Duration(seconds: 5));
      }
    }
  }

  /// Reload without a loading state (data/error state only).
  /// Use case: Get the latest data set from the database
  Future<void> refresh() async {
    state = await AsyncValue.guard(_repo.getUserDevices);
    if (state.hasError) _autoReload();
  }

  // /// Reload with a loading state
  // /// Use case: In case of error reload the screen
  // Future<void> reload() async {
  //   state = const AsyncValue.loading();
  //   await refresh();
  // }

  // /// Only update the state on success
  // /// Use case: Automatically and silently reload data in error screen
  // Future<void> autoReload() async {
  //   try {
  //     state = AsyncData(await _repo.getUserDevices());
  //   } catch (_, _) {
  //     debugPrint('log: Failed to auto reload devices');
  //   }
  // }

  Future<void> linkDevice(UdpDevice device) async {
    final data = state.requireValue;
    state = const AsyncValue.loading();
    try {
      final Map<String, dynamic> credentials = await _repo.registerDevice(
        device,
      );
      final success = await ref
          .read(udpServiceProvider)
          .sendDatabaseCredentials(
            deviceIP: device.ipAddress,
            mac: device.macAddress,
            credentials: credentials,
          );
      if (!success) {
        await _repo.unlinkDevice(device.macAddress);
        throw const DeviceException(
          'Did not receive a confirmation message from the targeted device!',
        );
      }
    } catch (error) {
      state = AsyncValue.data(data);
      rethrow;
    }

    await refresh();
  }

  bool isOwned(String macAddress) =>
      state.requireValue.any((d) => d.macAddress == macAddress);

  Future<void> unlinkDevice(int index) async {
    if (DemoAccount.isCurrentlyUsed) throw DemoAccountException();

    final currentDevices = state.requireValue;
    final deviceToRemove = currentDevices[index];
    await _repo.unlinkDevice(deviceToRemove.macAddress);
    final updatedDevices =
        currentDevices
            .where((device) => device.macAddress != deviceToRemove.macAddress)
            .toList();
    state = AsyncValue.data(updatedDevices);
  }

  ///Link a component to a room
  void assignRoom(int componentId, int? roomId) async {
    final devices = state.requireValue;
    List<Device> updatedDevices = List.from(devices);

    for (int i = 0; i < updatedDevices.length; i++) {
      final device = updatedDevices[i];
      int componentIndex = -1;
      for (int j = 0; j < device.components.length; j++) {
        if (device.components[j].id == componentId) {
          componentIndex = j;
          break;
        }
      }

      if (componentIndex != -1) {
        final updatedComponent = device.components[componentIndex].copyWithRoom(
          roomId,
        );
        final updatedComponents = List.of(device.components);
        updatedComponents[componentIndex] = updatedComponent;
        updatedDevices[i] = device.copyWith(components: updatedComponents);
        break; // Assuming componentId is unique across all devices
      }
    }
    state = AsyncValue.data(updatedDevices);
  }

  Future<void> renameDevice(int index, String newName) async {
    final currentDevices = state.requireValue;
    await _repo.renameDevice(currentDevices[index].macAddress, newName);
    final updatedDevices =
        currentDevices.map((device) {
          if (device.macAddress == currentDevices[index].macAddress) {
            return device.copyWith(name: newName);
          }
          return device;
        }).toList();
    state = AsyncValue.data(updatedDevices);
  }
}

@riverpod
class LinkDeviceInProgress extends _$LinkDeviceInProgress {
  @override
  bool build() => false;

  void setTrue() => state = true;

  void setFalse() => state = false;
}
