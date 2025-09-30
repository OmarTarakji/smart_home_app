import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'fingerprint_name_provider.g.dart';

@riverpod
Future<String> fingerprintNameOfId(Ref ref, int scannerId, int id) async {
  final response =
      await Supabase.instance.client
          .from('fingerprints')
          .select('name')
          .eq('fingerprint_id', id)
          .eq('sensor_id', scannerId)
          .single();
  return response['name'];
}
