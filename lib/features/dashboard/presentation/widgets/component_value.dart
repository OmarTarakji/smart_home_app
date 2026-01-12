import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';
import 'package:smart_home/core/utils/extensions.dart';
import 'package:smart_home/core/utils/text_formatter.dart';
import 'package:smart_home/features/dashboard/application/devices_last_active.dart';
import 'package:smart_home/features/dashboard/models/component.dart';
import 'package:smart_home/features/dashboard/models/component_type.dart';
import 'package:smart_home/features/dashboard/presentation/widgets/readings/actuator_toggle.dart';
import 'package:smart_home/features/dashboard/presentation/widgets/readings/no_reading.dart';
import 'package:smart_home/features/dashboard/presentation/widgets/readings/pir_reading.dart';

import '../../application/readings_provider.dart';
import '../../models/reading.dart';
import '../../models/reading_unit.dart';
import 'readings/fingerprint_reading.dart';
import 'readings/flame_sensor_reading.dart';
import 'readings/gas_reading.dart';
import 'readings/ldr_reading.dart';
import 'readings/numeric_reading.dart';

class ComponentValue extends ConsumerWidget {
  final Component component;
  final bool uniformSize;

  const ComponentValue({
    required this.component,
    this.uniformSize = false,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final ComponentReading? reading = ref.watch(
      componentReadingProvider(component.id),
    );
    final lastActive = ref.watch(devicesLastActiveProvider)[component.mac];
    final bool isOnline;
    if (lastActive != null &&
        lastActive.isAfter(
          DateTime.now().subtract(const Duration(minutes: 1)),
        )) {
      isOnline = true;
    } else {
      isOnline = false;
    }
    if (reading?.isLoading ?? false) {
      return NoReading(l10n.loading);
    }

    if (component.comType.type == CSType.sensor &&
        component.comType != ComponentType.flame &&
        reading == null) {
      return NoReading(
        l10n.componentValueNoReadingsYet,
      ); // Use localization key
    }

    final double? uniform = uniformSize ? 24 : null;
    final widget = switch (component.comType) {
      // temperature
      ComponentType.temperature => NumericReading(
        reading: reading!,
        unit: ReadingProperties.celsius.unit!,
        fontSize: uniform,
      ),
      // humidity or waterLevel
      ComponentType.humidity => NumericReading(
        reading: reading!,
        unit: ReadingProperties.percent.unit!,
        fontSize: uniform,
      ),
      ComponentType.waterLevel => NumericReading(
        reading: reading!,
        unit: ReadingProperties.percent.unit!,
        fontSize: uniform,
      ),
      // gas
      ComponentType.gas => GasReading(value: reading!.value, fontSize: uniform),
      // flame
      ComponentType.flame => FlameSensorReading(
        timestamp: reading?.timestamp,
        fontSize: uniform,
      ),
      // ldr
      ComponentType.ldr => LDRReading(value: reading!.value, fontSize: uniform),
      // pir
      ComponentType.pir => PIRReading(
        timestamp: reading!.timestamp,
        fontSize: uniform,
      ),
      // led
      ComponentType.light => ActuatorToggle(
        value: reading?.value,
        onToggle: () => onToggleLight(context, ref, reading?.value),
        type: ToggleType.light,
      ),
      // window or door
      ComponentType.door || ComponentType.window => ActuatorToggle(
        value: reading?.value,
        onToggle: () => onToggle(context, ref, reading?.value),
        type: ToggleType.openable,
      ),
      ComponentType.security => ActuatorToggle(
        value: reading?.value,
        onToggle: () => onToggle(context, ref, reading?.value),
        type: ToggleType.security,
      ),
      // fingerprint
      ComponentType.fingerprint => FingerprintReading(
        fpId: int.parse(reading!.value),
        scannerId: component.id,
        timestamp: reading.timestamp,
      ),
      _ => NoReading(l10n.componentValueUnhandledComponent),
    };
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        isOnline ? Colors.black : Colors.black38,
        BlendMode.dstIn,
      ),
      child: widget,
    );
  }

  Future<void> onToggleLight(
    BuildContext context,
    WidgetRef ref,
    String? value,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    try {
      await ref
          .read(readingsProvider.notifier)
          .toggleAdjustableControl(component.id, value ?? '-60');
    } catch (e) {
      if (context.mounted) {
        context.showErrorSnackBar(TextFormatter.getErrorMessage(e, l10n));
      }
    }
  }

  Future<void> onToggle(
    BuildContext context,
    WidgetRef ref,
    String? value,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    try {
      await ref
          .read(readingsProvider.notifier)
          .toggleControl(component.id, value ?? '0');
    } catch (e) {
      if (context.mounted) {
        context.showErrorSnackBar(TextFormatter.getErrorMessage(e, l10n));
      }
    }
  }
}
