import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../data/readings_repository.dart';
import '../domain/data_state.dart';
import '../domain/reading.dart';
import '../presentation/controllers/dashboard_screen_providers.dart';

part 'readings_provider.g.dart';

/// Returns the latest reading for the given component.
/// if value is loading return ComponentReading.loading()
@riverpod
ComponentReading? componentReading(Ref ref, int componentId) {
  final cr = ref.watch(readingsProvider);
  return cr.isLoading ? ComponentReading.loading() : cr.data[componentId];
}
//TODO: Cached values
//TODO: data initialized flag

@riverpod
ReadingsRepository readingsRepository(Ref ref) => ReadingsRepository();

@riverpod
class ReadingsNotifier extends _$ReadingsNotifier {
  late final _repo = ref.watch(readingsRepositoryProvider);
  late final _updateState = ref.read(readingsStateProvider.notifier).update;

  @override
  ComponentReadings build() {
    final RealtimeChannel channel = _repo.componentsReadingsChannel(
      onRecordInserted,
    );
    channel.subscribe((status, error) async {
      if (error != null) {
        _updateState(DataState.error);
        debugPrint('log: $error');
      }
      debugPrint('log: ${status.name}');
      if (status == RealtimeSubscribeStatus.subscribed) {
        final readings = await _repo.fetchLatestReadings();
        state = ComponentReadings(readings);
        _updateState(DataState.synced);
      }
    });

    ref.onDispose(() => channel.unsubscribe());

    return ComponentReadings.loading();
  }

  void onRecordInserted(PostgresChangePayload payload) {
    final insertedRecord = payload.newRecord;
    debugPrint(
      'log: ${insertedRecord['component_id']}: ${insertedRecord['value']}',
    );

    state = state.copyWith(
      insertedRecord['component_id'],
      ComponentReading.fromJson(insertedRecord),
    );
  }

  Future<void> toggleControl(int id, String value) async {
    final newValue = value == '0' ? '1' : '0';
    debugPrint('LOG: Updating value of $id form \'$value\' to \'$newValue\'');
    await _repo.updateValue(id, newValue);
    debugPrint('LOG: Update success');
  }

  Future<void> toggleAdjustableControl(int id, String value) async {
    int newValue = -int.parse(value);
    debugPrint('LOG: Updating value of $id form \'$value\' to \'$newValue\'');
    await _repo.updateValue(id, newValue.toString());
    debugPrint('LOG: Update success');
  }

  Future<void> setValue(int id, int value) async {
    debugPrint('LOG: Updating value of $id to \'$value\'');
    await _repo.updateValue(id, value.toString());
    debugPrint('LOG: Update success');
  }
}
