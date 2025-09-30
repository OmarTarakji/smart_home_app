import 'package:flutter/foundation.dart' show debugPrint;
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/utils/exceptions.dart';
import '../domain/device.dart';
import '../domain/udp_device.dart';

class DevicesRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Device>> getUserDevices() async {
    final response = await _supabase.rpc(
      'get_user_devices',
      params: {'p_user_id': _supabase.auth.currentUser!.id},
    );
    // debugPrint('Response: $response');

    if (response['success'] == false) {
      throw RetrieveDataException(response['message']);
    }

    debugPrint('log: ${response['devices']}');
    return (response['devices'] as List)
        .map((device) => Device.fromJson(device as Map<String, dynamic>))
        .toList();
  }

  /// Register a device with the server
  /// Returns the device's credentials to send to the device
  Future<Map<String, dynamic>> registerDevice(UdpDevice device) async {
    debugPrint('log: Registering device: $device');
    final response = await _supabase.rpc(
      'register_esp32',
      params: {
        ...device.toJson(),
        'p_owner_id': _supabase.auth.currentUser!.id,
      },
    );

    if (response['success'] == false) {
      throw DeviceException(response['message']);
    }
    debugPrint('log: Register device response: \n${response['device']}');
    return response['device'];
  }

  Future<void> unlinkDevice(String mac) async =>
      await _supabase.from('devices').delete().eq('mac_address', mac);

  Future<void> renameDevice(String mac, String name) async {
    await _supabase
        .from('devices')
        .update({'name': name})
        .eq('mac_address', mac);
    // TODO: Add proper error handling
  }

  Future<Map<String, DateTime>> getDevicesLastActive() async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return {};
    final response = await _supabase
        .from('devices')
        .select('mac_address, last_active')
        .eq('owner_id', userId);
    final devicesLastActive = <String, DateTime>{};
    for (final device in response) {
      devicesLastActive[device['mac_address']] =
          DateTime.parse(device['last_active']).toLocal();
    }
    return devicesLastActive;
  }
}
