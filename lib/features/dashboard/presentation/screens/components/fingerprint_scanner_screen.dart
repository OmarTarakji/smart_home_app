import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_home/core/l10n/app_localizations.dart'; // Import AppLocalizations
import 'package:smart_home/core/utils/extensions.dart';
import 'package:smart_home/features/dashboard/presentation/widgets/charts/count_chart.dart';
import 'package:smart_home/features/dashboard/presentation/widgets/component_extras.dart';
import 'package:smart_home/features/fingerprint/presentation/widgets/fingerprint_scans.dart';

import '../../../models/component.dart';
import '../component_screen.dart';

class FingerprintScannerScreen extends StatelessWidget {
  const FingerprintScannerScreen(this.component, {super.key});
  final Component component;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ComponentScreenSkeleton(
      component: component,
      child: Column(
        spacing: 16,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SvgPicture.asset(component.image, height: 120),
          ),
          FilledButton.icon(
            icon: const Icon(Icons.people_alt_rounded),
            onPressed: () {
              context.push('/fingerprints-manager/${component.id}');
            },
            label: Text(l10n.fingerprintManage), // Use localization key
            style: FilledButton.styleFrom(
              backgroundColor: context.colorScheme.tertiaryContainer,
              foregroundColor: context.colorScheme.onTertiaryContainer,
            ),
          ),
          CountChart(componentId: component.id),
          ComponentExtras(component.roomId, component.deviceInfo),
          const SizedBox(),
          Row(
            children: [
              const SizedBox(width: 10),
              Icon(Icons.history, size: 16, color: context.colorScheme.outline),
              const SizedBox(width: 6),
              Text(
                l10n.fingerprintScanHistory, // Use localization key
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: context.colorScheme.outline,
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(child: Divider(height: 1)),
              const SizedBox(width: 20),
            ],
          ),
          FingerprintScans(component.id),
        ],
      ),
    );
  }
}
