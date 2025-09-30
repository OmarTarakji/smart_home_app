import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_home/features/dashboard/domain/component.dart';
import 'package:smart_home/features/dashboard/presentation/screens/component_screen.dart';
import 'package:smart_home/features/dashboard/presentation/widgets/component_value.dart';

import '../../../domain/reading_unit.dart';
import '../../widgets/charts/light_chart.dart';
import '../../widgets/component_extras.dart';

class LightSensorScreen extends StatelessWidget {
  const LightSensorScreen(
    this.component, {
    required this.properties,
    super.key,
  });

  final Component component;
  final ReadingProperties properties;

  @override
  Widget build(BuildContext context) {
    return ComponentScreenSkeleton(
      component: component,
      child: Column(
        spacing: 16,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SvgPicture.asset(component.image, height: 120),
          ),
          ComponentValue(component: component),
          LightChart(component: component, properties: properties),
          ComponentExtras(component.roomId, component.deviceInfo),
        ],
      ),
    );
  }
}
