import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../domain/fingerprint.dart';

class FingerprintsRepository {
  final _supabase = Supabase.instance.client;

  Future<List<Fingerprint>> fetchFingerprints(int componentId) async {
    final response = await _supabase
        .from('fingerprints')
        .select('*')
        .eq('sensor_id', componentId);

    debugPrint('LOG: fingerprints: $response');

    final fingerprints =
        (response as List<dynamic>)
            .map((e) => Fingerprint.fromJson(e as Map<String, dynamic>))
            .toList();
    return fingerprints;
  }

  Future<Fingerprint> renameFingerprint(
    int fingerprintId,
    String newName,
  ) async {
    final response =
        await _supabase
            .from('fingerprints')
            .update({'name': newName})
            .eq('id', fingerprintId)
            .select()
            .single();
    debugPrint('LOG: $response');

    return Fingerprint.fromJson(response);
  }

  Future<String> fetchApiKey(String mac) async {
    final response =
        await _supabase
            .from('devices')
            .select('api_key')
            .eq('mac_address', mac)
            .single();
    debugPrint('LOG: $response');
    return response['api_key'] as String;
  }

  Future<List<FingerprintScan>> fetchLatestScans(int scannerId) async {
    final List response = await _supabase.rpc(
      'get_fingerprint_history',
      params: {'p_component_id': scannerId},
    );

    debugPrint('LOG: Scans: $response');

    return response.map((scan) => FingerprintScan.fromJson(scan)).toList();
  }
}
