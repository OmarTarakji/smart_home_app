import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_home/core/widgets/loading_body.dart';
import 'package:smart_home/features/dashboard/models/component.dart';
import 'package:smart_home/features/dashboard/models/component_type.dart';
import 'package:smart_home/features/dashboard/presentation/screens/components/adjustable_led.screen.dart';
import 'package:smart_home/features/dashboard/presentation/screens/components/fingerprint_scanner_screen.dart';
import 'package:smart_home/features/dashboard/presentation/screens/components/flame_sensor_screen.dart';
import 'package:smart_home/features/dashboard/presentation/screens/components/numeric_component_screen.dart';

import '../../models/reading_unit.dart';
import '../controllers/component_provider.dart';
import '../widgets/component_popup_menu.dart';
import 'components/light_sensor_screen.dart';
import 'components/motion_sensor_screen.dart';
import 'components/switch_screen.dart';

class ComponentScreenRouter extends ConsumerWidget {
  const ComponentScreenRouter({required this.id, super.key});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncComponent = ref.watch(componentProvider(id));

    asyncComponent.whenOrNull(
      data: (data) => debugPrint("component provided: ${data.comType}"),
    );

    return asyncComponent.when(
      data: (component) => switch (component.comType) {
        ComponentType.fingerprint => FingerprintScannerScreen(component),
        ComponentType.temperature => NumericComponentScreen(
          component,
          properties: ReadingProperties.celsius,
        ),
        ComponentType.waterLevel ||
        ComponentType.humidity => NumericComponentScreen(
          component,
          properties: ReadingProperties.percent,
        ),
        ComponentType.gas => NumericComponentScreen(
          component,
          properties: ReadingProperties.analog,
        ),
        ComponentType.flame => FlameSensorScreen(component),
        ComponentType.pir => MotionSensorScreen(component),
        ComponentType.ldr => LightSensorScreen(
          component,
          properties: ReadingProperties.analog,
        ),
        ComponentType.window => SwitchScreen(component),
        ComponentType.door => SwitchScreen(component),
        ComponentType.light => AdjustableLedScreen(component),
        _ => throw UnimplementedError(),
      },
      error: (error, stackTrace) => ErrorWidget(error),
      loading: () => const Scaffold(body: LoadingBody('Loading component...')),
    );
  }
}

class ComponentScreenSkeleton extends StatelessWidget {
  const ComponentScreenSkeleton({
    required this.component,
    required this.child,
    super.key,
  });
  final Component component;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          component.name ?? component.comType.getLocalizedName(context),
        ),
        centerTitle: true,
        actions: [ComponentPopupMenu(onRename: () {}, onPickIcon: () {})],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(padding: const EdgeInsets.all(16.0), child: child),
        ),
      ),
    );
  }
}
