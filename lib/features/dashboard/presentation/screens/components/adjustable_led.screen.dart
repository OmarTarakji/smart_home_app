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

import '../../../domain/component.dart';
import '../../widgets/component_extras.dart';

class AdjustableLedScreen extends StatelessWidget {
  const AdjustableLedScreen(this.component, {super.key});

  final Component component;

  @override
  Widget build(BuildContext context) {
    return ComponentScreenSkeleton(
      component: component,
      child: SizedBox(
        height: 720,
        child: Column(
          children: [
            const Spacer(flex: 1),
            SvgPicture.asset(component.image, width: 120),
            const Spacer(flex: 2),
            _buildSlider(),
            const SizedBox(height: 30),
            ComponentValue(component: component),
            const Spacer(flex: 2),
            ComponentExtras(component.roomId, component.deviceInfo),
          ],
        ),
      ),
    );
  }

  Consumer _buildSlider() {
    return Consumer(
      builder: (context, ref, child) {
        final l10n = AppLocalizations.of(context)!;
        final reading = ref.watch(componentReadingProvider(component.id));
        final value = double.tryParse(reading?.value ?? '-60');
        final isLoading = reading?.isLoading ?? false;
        return CustomLevelSlider(
          initialValue: isLoading ? 60 : value!.abs(),
          isOff: value == null || value <= 0,
          onChanged:
              isLoading
                  ? null
                  : (newValue) async {
                    try {
                      final val = (value! < 0 ? -newValue : newValue).toInt();
                      await ref
                          .read(readingsProvider.notifier)
                          .setValue(component.id, val);
                    } catch (e) {
                      if (context.mounted) {
                        context.showErrorSnackBar(
                          TextFormatter.getErrorMessage(e, l10n),
                        );
                      }
                    }
                  },
        );
      },
    );
  }
}
