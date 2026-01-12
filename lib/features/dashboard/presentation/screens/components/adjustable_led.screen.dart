import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';
import 'package:smart_home/core/utils/extensions.dart';
import 'package:smart_home/core/utils/text_formatter.dart';
import 'package:smart_home/features/dashboard/application/readings_provider.dart';
import 'package:smart_home/features/dashboard/presentation/screens/component_screen.dart';
import 'package:smart_home/features/dashboard/presentation/widgets/component_value.dart';
import 'package:smart_home/features/dashboard/presentation/widgets/custom_level_slider.dart';

import '../../../models/component.dart';
import '../../widgets/component_extras.dart';

class AdjustableLedScreen extends StatelessWidget {
  const AdjustableLedScreen(this.component, {super.key});

  final Component component;

  @override
  Widget build(BuildContext context) {
    return ComponentScreenSkeleton(
      component: component,
      child: Column(
        spacing: 30,
        children: [
          Padding(
            padding: const .only(top: 10),
            child: SvgPicture.asset(component.image, width: 120),
          ),
          _Slider(componentId: component.id),
          ComponentValue(component: component),
          ComponentExtras(component.roomId, component.deviceInfo),
        ],
      ),
    );
  }
}

class _Slider extends ConsumerWidget {
  const _Slider({required this.componentId, super.key});

  final int componentId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final reading = ref.watch(componentReadingProvider(componentId));
    final isLoading = reading?.isLoading ?? false;
    final value = double.tryParse(reading?.value ?? '-60');

    return CustomLevelSlider(
      initialValue: isLoading ? 60 : value!.abs(),
      isOff: value == null || value <= 0,
      onChanged: (newValue) async {
        if (isLoading) return;
        try {
          final val = (value! < 0 ? -newValue : newValue).toInt();
          await ref.read(readingsProvider.notifier).setValue(componentId, val);
        } catch (e) {
          if (context.mounted) {
            context.showErrorSnackBar(TextFormatter.getErrorMessage(e, l10n));
          }
        }
      },
    );
  }
}
