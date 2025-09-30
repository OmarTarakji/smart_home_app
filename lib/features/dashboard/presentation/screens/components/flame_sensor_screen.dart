import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';
import 'package:smart_home/core/providers/language_provider.dart';
import 'package:smart_home/core/utils/extensions.dart';
import 'package:smart_home/core/utils/text_formatter.dart';
import 'package:smart_home/core/widgets/error_screen.dart';
import 'package:smart_home/features/dashboard/application/flame_activity_provider.dart';
import 'package:smart_home/features/dashboard/application/readings_provider.dart';
import 'package:smart_home/features/dashboard/domain/reading.dart';
import 'package:smart_home/features/dashboard/presentation/screens/component_screen.dart';
import 'package:smart_home/features/dashboard/presentation/widgets/component_extras.dart';

import '../../../domain/component.dart';
import '../../widgets/readings/flame_sensor_reading.dart';
import '../../widgets/readings/no_reading.dart';

class FlameSensorScreen extends StatelessWidget {
  const FlameSensorScreen(this.component, {super.key});

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
          _buildValue(l10n),
          ComponentExtras(component.roomId, component.deviceInfo),
          Row(
            children: [
              const SizedBox(width: 10),
              Text(
                l10n.latestActivities,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: context.colorScheme.outline,
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              color: context.colorScheme.secondaryContainer,
              borderRadius: const BorderRadius.all(Radius.circular(30)),
            ),
            alignment: Alignment.center,
            child: _buildLatestActivities(l10n),
          ),
        ],
      ),
    );
  }

  Widget _buildValue(AppLocalizations l10n) {
    return Consumer(
      builder: (context, ref, child) {
        final ComponentReading? reading = ref.watch(
          componentReadingProvider(component.id),
        );

        if (reading?.isLoading ?? false) {
          return NoReading(l10n.loading);
        }
        return FlameSensorReading(timestamp: reading?.timestamp, fontSize: 40);
      },
    );
  }

  Widget _buildLatestActivities(AppLocalizations l10n) {
    return Consumer(
      builder: (context, ref, child) {
        final readings = ref.watch(flameActivityProvider(component.id));
        final locale = ref.watch(selectedLanguageProvider);

        return readings.when(
          data: (data) {
            if (data.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  l10n.flameSensorNoActivities,
                ), // Use localization key
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.length,
              itemBuilder:
                  (context, index) => ListTile(
                    leading: Icon(
                      Icons.error_outline,
                      color: context.colorScheme.error,
                      size: 30,
                    ),
                    title: Text(
                      l10n.flameSensorFlameDetected,
                    ), // Use localization key

                    subtitle: Text(
                      TextFormatter.formatDate(
                        data[index].timestamp,
                        locale,
                        l10n,
                      ),
                    ),
                  ),
            );
          },
          error: (error, stackTrace) {
            return StyledError(error: error, showLoadingIndicator: false);
          },
          loading: () {
            return const Padding(
              padding: EdgeInsets.all(24.0),
              child: CircularProgressIndicator(),
            );
          },
        );
      },
    );
  }
}
