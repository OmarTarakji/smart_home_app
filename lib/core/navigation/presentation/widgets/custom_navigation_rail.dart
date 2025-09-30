import 'package:flutter/material.dart';

import 'custom_navigation.dart';

class CustomNavigationRail extends CustomNavigation {
  final Widget body;

  const CustomNavigationRail({
    required this.body,
    required super.destinations,
    required super.selectedIndex,
    required super.onDestinationSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Ink(
            width: 85,
            height: double.infinity,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: buildButtons(context, double.infinity),
                );
              },
            ),
          ),
          const VerticalDivider(width: 1),
          Expanded(child: body),
        ],
      ),
    );
  }
}
