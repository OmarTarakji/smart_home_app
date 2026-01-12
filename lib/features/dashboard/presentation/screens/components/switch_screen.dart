import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_home/features/dashboard/presentation/screens/component_screen.dart';

import '../../../models/component.dart';
import '../../widgets/component_extras.dart';
import '../../widgets/component_value.dart';

class SwitchScreen extends StatelessWidget {
  const SwitchScreen(this.component, {super.key});

  final Component component;

  @override
  build(BuildContext context) {
    return ComponentScreenSkeleton(
      component: component,
      child: SizedBox(
        height: 600,
        child: Column(
          children: [
            const Spacer(),
            SvgPicture.asset(component.image, height: 200),
            const Spacer(),
            ComponentValue(component: component),
            const Spacer(),
            ComponentExtras(component.roomId, component.deviceInfo),
          ],
        ),
      ),
    );
  }
}
