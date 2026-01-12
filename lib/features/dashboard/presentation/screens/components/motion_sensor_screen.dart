import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_home/features/dashboard/models/component.dart';
import 'package:smart_home/features/dashboard/presentation/screens/component_screen.dart';

import '../../widgets/charts/count_chart.dart';
import '../../widgets/component_extras.dart';
import '../../widgets/component_value.dart';

class MotionSensorScreen extends StatelessWidget {
  const MotionSensorScreen(this.component, {super.key});

  final Component component;

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
          CountChart(componentId: component.id),
          ComponentExtras(component.roomId, component.deviceInfo),
        ],
      ),
    );
  }
}
