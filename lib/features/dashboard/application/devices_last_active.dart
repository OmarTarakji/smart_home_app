import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_home/features/devices/application/devices_notifier.dart';

part 'devices_last_active.g.dart';

@riverpod
class DevicesLastActive extends _$DevicesLastActive {
  late final repo = ref.watch(devicesRepositoryProvider);
  @override
  Map<String, DateTime> build() {
    fetchLastActive();
    final timer = Timer.periodic(const Duration(seconds: 15), (timer) {
      fetchLastActive();
    });

    ref.onDispose(() {
      timer.cancel();
    });

    return {};
  }

  void fetchLastActive() async {
    state = await repo.getDevicesLastActive();
    debugPrint('LOG: last active: $state');
  }
}
