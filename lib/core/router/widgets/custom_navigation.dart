import 'package:flutter/material.dart';
import 'package:smart_home/core/utils/extensions.dart';
import 'package:smart_home/core/widgets/vertical_button.dart';

abstract class CustomNavigation extends StatelessWidget {
  const CustomNavigation({
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
    super.key,
  });

  final List<CustomDestination> destinations;
  final int selectedIndex;
  final void Function(int index) onDestinationSelected;

  List<VerticalButton> buildButtons(BuildContext context, width) {
    return [
      for (final d in destinations)
        VerticalButton(
          icon: d.icon,
          label: d.label,
          width: width,
          onPressed: () => onDestinationSelected(destinations.indexOf(d)),
          color: selectedIndex == destinations.indexOf(d)
              ? context.colorScheme.primary
              : null,
        ),
    ];
  }
}

class CustomDestination {
  final IconData icon;
  final String label;

  const CustomDestination({required this.icon, required this.label});
}
