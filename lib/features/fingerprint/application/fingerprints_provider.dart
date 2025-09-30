import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_home/core/utils/exceptions.dart';
import 'package:smart_home/features/devices/application/devices_notifier.dart';
import 'package:smart_home/features/fingerprint/domain/add_fingerprint_response.dart';

import '../../dashboard/application/chart_providers.dart';
import '../data/fingerprint_udp_service.dart';
import '../data/fingerprints_repository.dart';
import '../domain/add_fingerprint_state.dart';
import '../domain/fingerprint.dart';
import '../presentation/controllers/add_fingerprint_controller.dart';
import 'latest_scans_provider.dart';

part 'fingerprints_provider.g.dart';

@riverpod
FingerprintUdpService fpUdpService(Ref ref) => FingerprintUdpService();

@riverpod
FingerprintsRepository fingerprintsRepository(Ref ref) =>
    FingerprintsRepository();

@riverpod
class ComponentFingerprintsNotifier extends _$ComponentFingerprintsNotifier {
  late final _repo = ref.watch(fingerprintsRepositoryProvider);

  @override
  Future<List<Fingerprint>> build(int componentId) async {
    return await _repo.fetchFingerprints(componentId);
  }

  Future<void> deleteFingerprint(int fingerprintId) async {
    final mac = _getDeviceMac(componentId);
    final udpService = ref.watch(fpUdpServiceProvider);

    final deviceIp = await udpService.getDeviceIpByMac(mac);
    if (deviceIp == null) {
      throw const FingerprintException(
        'Failed to find to device',
        'Make sure you\'re connected to the same Wi-Fi network and VPN is turned off.',
      );
    }
    final apiKey = await _repo.fetchApiKey(mac);

    udpService.deleteFingerprint(
      apiKey: apiKey,
      fingerprintId: fingerprintId,
      sensorId: componentId,
      deviceIP: deviceIp,
      mac: mac,
    );

    state = AsyncData(
      state.asData!.value
          .where((f) => f.sensorFingerprintId != fingerprintId)
          .toList(),
    );
  }

  Future<void> renameFingerprint(int fingerprintId, String newName) async {
    final newFingerprint = await _repo.renameFingerprint(
      fingerprintId,
      newName,
    );
    state = AsyncData(
      state.asData!.value
          .map((f) => f.id == fingerprintId ? newFingerprint : f)
          .toList(),
    );
  }

  // void addFingerprint(Fingerprint fingerprint) {
  //   state = AsyncData([...state.asData!.value, fingerprint]);
  // }

  Future<void> enrollFingerprint(int componentId, String name) async {
    final loadingNotifier = ref.read(addFingerprintProvider.notifier);
    final mac = _getDeviceMac(componentId);

    loadingNotifier.setState(
      const AddFingerprintResponse(AddFpState.fetchingApiKey),
    );

    try {
      final apiKey = await _repo.fetchApiKey(mac);
      loadingNotifier.setState(
        const AddFingerprintResponse(AddFpState.connectingToDevice),
      );

      final udpService = ref.watch(fpUdpServiceProvider);

      final deviceIp = await udpService.getDeviceIpByMac(mac);
      if (deviceIp == null) {
        throw const FingerprintException(
          'Failed to find to device',
          'Make sure you\'re connected to the same Wi-Fi network and VPN is turned off.',
        );
      }

      udpService
          .startFingerprintAddingSequence(
            apiKey: apiKey,
            name: name,
            sensorId: componentId,
            deviceIP: deviceIp,
            mac: mac,
          )
          .listen((event) => loadingNotifier.setState(event));
    } finally {
      loadingNotifier.setState(const AddFingerprintResponse(AddFpState.none));
    }
  }

  String _getDeviceMac(int componentId) {
    final devices = ref.read(devicesProvider).asData?.value;
    if (devices == null) {
      throw const FingerprintException(
        'No devices found',
        'Please add a device first.',
      );
    }

    final device = devices.firstWhere(
      (d) => d.components.any((c) => c.id == componentId),
      orElse: () {
        throw const FingerprintException(
          'Device not found',
          'The component does not belong to any known device.',
        );
      },
    );
    return device.macAddress;
  }

  Future<void> deleteAll() async {
    final mac = _getDeviceMac(componentId);
    final udpService = ref.watch(fpUdpServiceProvider);

    final deviceIp = await udpService.getDeviceIpByMac(mac);
    if (deviceIp == null) {
      throw const FingerprintException(
        'Failed to find to device',
        'Make sure you\'re connected to the same Wi-Fi network and VPN is turned off.',
      );
    }
    final apiKey = await _repo.fetchApiKey(mac);

    await udpService.deleteAllFingerprints(
      apiKey: apiKey,
      sensorId: componentId,
      deviceIP: deviceIp,
      mac: mac,
    );
    ref.invalidate(latestScansProvider(componentId));
    ref.invalidate(hourlyReadingsCountProvider(componentId));

    state = const AsyncData([]);
  }
}
