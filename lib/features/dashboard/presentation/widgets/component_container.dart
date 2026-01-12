import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_home/core/constants/images.dart';
import 'package:smart_home/core/utils/extensions.dart';
import 'package:smart_home/features/dashboard/models/component.dart';

import 'component_value.dart';

abstract class ComponentContainer extends StatelessWidget {
  const ComponentContainer({
    required this.component,
    this.height,
    this.borderRadius = 28,
    super.key,
  });
  final Component component;
  final double? height;
  final double borderRadius;

  Widget buildChild(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(borderRadius),
      onTap: () => context.go('/dashboard/components/${component.id}'),
      child: Ink(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: context.colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        // alignment: Alignment.center,
        height: height,
        child: buildChild(context),
      ),
    );
  }
}

class ComponentCard extends ComponentContainer {
  const ComponentCard({required super.component, super.key});

  @override
  Widget buildChild(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: SvgPicture.asset(
            component.image,
            height: 60,
            placeholderBuilder: (context) {
              return SvgPicture.asset(Images.ESP32, height: 60);
            },
          ),
        ),
        const SizedBox(height: 5),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            component.name ?? component.comType.getLocalizedName(context),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colorScheme.onSecondaryContainer,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Expanded(
          child: Align(
            alignment: AlignmentDirectional.bottomEnd,
            child: ComponentValue(component: component),
          ),
        ),
      ],
    );
  }
}

class ComponentTile extends ComponentContainer {
  const ComponentTile({
    required super.component,
    super.height = 72,
    super.borderRadius = 24,
    super.key,
  });

  @override
  Widget buildChild(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          component.image,
          height: 50,
          placeholderBuilder: (context) {
            return SvgPicture.asset(Images.ESP32, height: 50);
          },
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            component.name ?? component.comType.getLocalizedName(context),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colorScheme.onSecondaryContainer,
            ),
          ),
        ),
        const SizedBox(width: 5),
        Container(
          width: 100,
          alignment: AlignmentDirectional.centerEnd,
          child: ComponentValue(component: component, uniformSize: true),
        ),
        const SizedBox(width: 5),
      ],
    );
  }
}
