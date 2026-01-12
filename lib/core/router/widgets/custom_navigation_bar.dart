import 'package:flutter/material.dart';

import 'custom_navigation.dart';

class CustomNavigationBar extends CustomNavigation {
  const CustomNavigationBar({
    required super.destinations,
    required super.selectedIndex,
    required super.onDestinationSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            height: 1,
            color: Theme.of(context).colorScheme.outline.withAlpha(50),
          ),
          Ink(
            width: double.infinity,
            // height: 75,
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth / destinations.length;
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: buildButtons(context, width),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
