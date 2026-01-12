import 'dart:async';

import 'package:flutter/foundation.dart' show debugPrint;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/udp_service.dart';
import '../domain/udp_device.dart';

part 'udp_service_provider.g.dart';

@riverpod
DeviceUdpService udpService(Ref ref) {
  final repository = DeviceUdpService();
  ref.onDispose(() => repository.dispose());
  return repository;
}

@riverpod
class DeviceDiscovery extends _$DeviceDiscovery {
  late final _service = ref.watch(udpServiceProvider);
  StreamSubscription<UdpDevice>? _deviceSubscription;

  bool _shouldRefresh = false;

  @override
  List<UdpDevice> build() {
    debugPrint('DeviceDiscovery build()');
    ref.onDispose(() => _deviceSubscription?.cancel());

    _deviceSubscription = _service.deviceStream.listen((device) {
      if (_shouldRefresh) {
        state = [device];
        _shouldRefresh = false;
      } else {
        // debugPrint('Device: $device');
        state = [...state, device];
      }
    });
    Future.microtask(refresh);
    return <UdpDevice>[];
  }

  Future<void> refresh() async {
    if (ref.read(discoveryLoadingStateProvider)) return;
    ref.read(discoveryLoadingStateProvider.notifier).setCoolDown();
    _shouldRefresh = true;
    await _service.discoverDevices();
  }

  void onDelayed() {
    if (_shouldRefresh) {
      state = [];
      _shouldRefresh = false;
      ref.read(reloadAttemptsProvider.notifier).increment();
    }
  }
}

@riverpod
class DiscoveryLoadingState extends _$DiscoveryLoadingState {
  @override
  bool build() {
    debugPrint('DiscoverLoadingState build()');

    return false;
  }

  void setCoolDown() async {
    state = true;

    Future.delayed(const Duration(seconds: 1), () {
      ref.read(deviceDiscoveryProvider.notifier).onDelayed();
    });
    Future.delayed(const Duration(seconds: 5), () {
      state = false;
    });
  }
}

@riverpod
class ReloadAttempts extends _$ReloadAttempts {
  @override
  int build() {
    debugPrint('ReloadAttempts build()');

    return 0;
  }

  void increment() => state++;
}
