import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_home/core/utils/exceptions.dart'
    show NetworkInfoException, PermissionException;

part 'wifi_config_provider.g.dart';

@riverpod
Future<bool> locationPermission(Ref ref) async {
  final bool hasPermission =
      await Permission.location
          .onDeniedCallback(() {
            debugPrint('Exception: Location denied');
            throw const PermissionException('Location denied');
          })
          .onPermanentlyDeniedCallback(() {
            debugPrint('Exception: Location permanently denied');
            throw const PermissionException('Location permanently denied');
          })
          .request()
          .isGranted;
  debugPrint('Location permission provider: $hasPermission');
  return hasPermission;
}

@riverpod
class NetworkNotifier extends _$NetworkNotifier {
  final _info = NetworkInfo();

  @override
  WifiInfo build() {
    Future.microtask(() => getInfo());
    return WifiInfo();
  }

  Future<String> getInfo() async {
    await ref.read(locationPermissionProvider.future);
    final String? ssid = await _info.getWifiName();
    if (ssid == null) {
      state = WifiInfo();
      throw const NetworkInfoException('Couldn\'t find Wi-Fi network');
    }
    state = state.copyWith(ssid.replaceAll('"', ''));
    state.macAddress = await _info.getWifiBSSID();
    return state.ssid!;
  }

  void setPassword(String? password) => state.password = password;
}

class WifiInfo {
  final String? ssid;
  String _macAddress;
  String? password;

  WifiInfo({this.ssid, String? macAddress})
    : _macAddress = macAddress ?? '00:00:00:00:00:00';

  WifiInfo copyWith(String? ssid) =>
      WifiInfo(ssid: ssid, macAddress: _macAddress);

  set macAddress(String? macAddress) => _macAddress = macAddress ?? _macAddress;

  String get macAddress => _macAddress;
}
