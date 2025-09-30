import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';
import 'package:smart_home/core/providers/language_provider.dart';
import 'package:smart_home/core/utils/text_formatter.dart';
import 'package:smart_home/features/dashboard/application/fingerprint_name_provider.dart';

class FingerprintReading extends ConsumerWidget {
  const FingerprintReading({
    required this.fpId,
    required this.scannerId,
    required this.timestamp,
    super.key,
  });

  final DateTime timestamp;
  final int fpId;
  final int scannerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(fingerprintNameOfIdProvider(scannerId, fpId)).value;
    final l10n = AppLocalizations.of(context)!;
    final locale = ref.watch(selectedLanguageProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (name != null)
          Expanded(
            child: Text(
              name,
              softWrap: false,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        const SizedBox(height: 2),
        Expanded(
          child: Text(
            TextFormatter.formatDate(timestamp, locale, l10n),
            style: Theme.of(context).textTheme.bodySmall,
            softWrap: false,
            overflow: TextOverflow.fade,
          ),
        ),
      ],
    );
  }
}
