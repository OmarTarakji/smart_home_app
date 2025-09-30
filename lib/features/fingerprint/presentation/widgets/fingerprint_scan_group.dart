import 'package:flutter/material.dart';
import 'package:smart_home/core/utils/extensions.dart';
import 'package:smart_home/features/fingerprint/domain/fingerprint.dart';

import 'fingerprint_scan_tile.dart';

class FingerprintScanGroup extends StatelessWidget {
  const FingerprintScanGroup({
    required this.title,
    required this.scans,
    super.key,
  });

  final String title;
  final List<FingerprintScan> scans;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: context.colorScheme.outline,
            ),
          ),
        ),
        ...scans.map((notification) => FingerprintScanTile(scan: notification)),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
