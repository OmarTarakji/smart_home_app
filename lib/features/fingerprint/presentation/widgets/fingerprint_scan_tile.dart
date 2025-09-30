import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';
import 'package:smart_home/core/providers/language_provider.dart';
import 'package:smart_home/core/utils/extensions.dart';
import 'package:smart_home/core/utils/text_formatter.dart';
import 'package:smart_home/features/fingerprint/domain/fingerprint.dart';

class FingerprintScanTile extends ConsumerWidget {
  const FingerprintScanTile({required this.scan, super.key});

  final FingerprintScan scan;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final locale = ref.watch(selectedLanguageProvider);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Icon(Icons.fingerprint, size: 35, color: Colors.green),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              spacing: 2,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  scan.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  TextFormatter.formatDate(scan.timeScanned, locale, l10n),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.outline,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
