import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_home/features/dashboard/application/readings_provider.dart';
import 'package:smart_home/features/fingerprint/domain/fingerprint.dart';

import 'fingerprints_provider.dart';

part 'latest_scans_provider.g.dart';

@riverpod
Future<List<FingerprintScan>> latestScans(Ref ref, int scannerId) async {
  final repo = ref.watch(fingerprintsRepositoryProvider);
  ref.watch(componentReadingProvider(scannerId));
  return await repo.fetchLatestScans(scannerId);
}
