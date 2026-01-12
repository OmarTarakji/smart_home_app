import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/reading.dart';

class ReadingsRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<Map<int, ComponentReading?>> fetchLatestReadings() async {
    final id = _supabase.auth.currentUser!.id;
    final List<Map<String, dynamic>> response = await _supabase.rpc(
      'user_component_latest_values',
      params: {'p_user_id': id},
    );

    final readings = <int, ComponentReading?>{
      for (Map<String, dynamic> reading in response)
        reading['component_id']: reading['value'] == null
            ? null
            : ComponentReading.fromJson(reading),
    };
    return readings;
  }

  RealtimeChannel componentsReadingsChannel(
    void Function(PostgresChangePayload) callback,
  ) {
    final userId = _supabase.auth.currentUser!.id;

    return _supabase
        .channel('public:$userId')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'component_history',
          callback: callback,
        );
  }

  Future<void> updateValue(int id, String value) async {
    final resp = await _supabase.from('component_history').insert({
      'component_id': id,
      'value': value,
    }).select();
    debugPrint(resp.toString());
  }

  Future<List<AvgComponentReading>> fetchDayReadingsAvg(
    int id,
    DateTime date,
  ) async {
    debugPrint(
      'LOG: DateTime: $date, Time Zone: ${date.timeZoneName}, iso: ${date.toUtc().toIso8601String()}',
    );

    final List<dynamic> response = await _supabase.rpc(
      'get_thirty_minute_averages',
      params: {
        'p_component_id': '$id',
        'p_start_time': date.toUtc().toIso8601String(),
      },
    );

    return response.map((e) => AvgComponentReading.fromJson(e)).toList();
  }

  Future<List<ComponentReadingCount>> fetchHourlyReadingsCount(
    int id,
    DateTime date,
  ) async {
    debugPrint(
      'LOG: DateTime: $date, Time Zone: ${date.timeZoneName}, iso: ${date.toUtc().toIso8601String()}',
    );

    final List<dynamic> response = await _supabase.rpc(
      'get_record_counts_hourly',
      params: {
        'p_component_id': '$id',
        'p_start_time': date.toUtc().toIso8601String(),
      },
    );

    return response.map((e) => ComponentReadingCount.fromJson(e)).toList();
  }
}
