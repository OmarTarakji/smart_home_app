import 'package:smart_home/features/dashboard/models/reading.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FlameActivityRepository {
  final _supabase = Supabase.instance.client;

  Future<List<ComponentReading>> fetch(int componentId) async {
    final response = await _supabase
        .from('component_history')
        .select('value, timestamp')
        .eq('component_id', componentId);

    return response.map((e) => ComponentReading.fromJson(e)).toList();
  }
}
