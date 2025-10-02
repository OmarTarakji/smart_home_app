import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';
import 'package:smart_home/core/widgets/error_screen.dart';

import '../../application/latest_scans_provider.dart';
import '../../domain/fingerprint.dart';
import 'fingerprint_scan_group.dart';

class FingerprintScans extends ConsumerWidget {
  const FingerprintScans(this.componentId, {super.key});

  final int componentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scansAsync = ref.watch(latestScansProvider(componentId));
    return scansAsync.when(
      data: (scans) {
        if (scans.isEmpty) {
          return Center(child: Text(l10n.fingerprintNoHistory));
        }

        final now = DateTime.now();
        final today = <FingerprintScan>[];
        final yesterday = <FingerprintScan>[];
        final thisWeek = <FingerprintScan>[];
        final older = <FingerprintScan>[];

        for (final scan in scans) {
          final notificationDate = scan.timeScanned;
          final difference = now.difference(notificationDate).inDays;

          if (difference == 0 && notificationDate.day == now.day) {
            today.add(scan);
          } else if (difference == 1 ||
              (difference == 0 && notificationDate.day == now.day - 1)) {
            yesterday.add(scan);
          } else if (difference < 7 &&
              notificationDate.weekday <= now.weekday) {
            thisWeek.add(scan);
          } else {
            older.add(scan);
          }
        }
        return ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: [
            if (today.isNotEmpty)
              FingerprintScanGroup(title: l10n.dateToday, scans: today),
            if (yesterday.isNotEmpty)
              FingerprintScanGroup(title: l10n.dateYesterday, scans: yesterday),
            if (thisWeek.isNotEmpty)
              FingerprintScanGroup(title: l10n.dateThisWeek, scans: thisWeek),
            if (older.isNotEmpty)
              FingerprintScanGroup(title: l10n.dateOlder, scans: older),
          ],
        );
      },
      error: (e, st) => Center(child: StyledError(error: e, stackTrace: st)),
      loading:
          () => const Padding(
            padding: EdgeInsets.all(20),
            child: CircularProgressIndicator(),
          ),
    );
  }
}
