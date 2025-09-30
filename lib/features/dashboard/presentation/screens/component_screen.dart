import 'package:flutter/material.dart';
import 'package:smart_home/features/dashboard/domain/component.dart';
import 'package:smart_home/features/dashboard/domain/component_type.dart';
import 'package:smart_home/features/dashboard/presentation/screens/components/adjustable_led.screen.dart';
import 'package:smart_home/features/dashboard/presentation/screens/components/fingerprint_scanner_screen.dart';
import 'package:smart_home/features/dashboard/presentation/screens/components/flame_sensor_screen.dart';
import 'package:smart_home/features/dashboard/presentation/screens/components/numeric_component_screen.dart';

import '../../domain/reading_unit.dart';
import '../widgets/component_popup_menu.dart';
import 'components/light_sensor_screen.dart';
import 'components/motion_sensor_screen.dart';
import 'components/switch_screen.dart';

class ComponentScreenRouter extends StatelessWidget {
  const ComponentScreenRouter(this.component, {super.key});

  final Component component;

  @override
  Widget build(BuildContext context) {
    switch (component.comType) {
      case ComponentType.fingerprint:
        return FingerprintScannerScreen(component);
      case ComponentType.temperature:
        return NumericComponentScreen(
          component,
          properties: ReadingProperties.celsius,
        );
      case ComponentType.humidity:
        return NumericComponentScreen(
          component,
          properties: ReadingProperties.percent,
        );
      case ComponentType.waterLevel:
        return NumericComponentScreen(
          component,
          properties: ReadingProperties.percent,
        );
      case ComponentType.gas:
        return NumericComponentScreen(
          component,
          properties: ReadingProperties.analog,
        );
      case ComponentType.flame:
        return FlameSensorScreen(component);
      case ComponentType.pir:
        return MotionSensorScreen(component);
      case ComponentType.ldr:
        return LightSensorScreen(
          component,
          properties: ReadingProperties.analog,
        );
      case ComponentType.window:
        return SwitchScreen(component);
      case ComponentType.door:
        return SwitchScreen(component);
      case ComponentType.light:
        return AdjustableLedScreen(component);
      case ComponentType.buzzer:
        throw UnimplementedError();
      case ComponentType.security:
        return SwitchScreen(component);
    }
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
