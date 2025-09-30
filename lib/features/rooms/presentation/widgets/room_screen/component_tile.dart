import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_home/core/utils/extensions.dart';
import 'package:smart_home/core/utils/smart_home_icons.dart';
import 'package:smart_home/features/dashboard/domain/component.dart';

import '../../../../dashboard/presentation/widgets/component_value.dart';

enum TileMode { reading, add, remove }

class ComTile extends StatelessWidget {
  final Component component;
  final TileMode tileMode;

  final VoidCallback? onPressed;

  const ComTile({
    required this.component,
    this.tileMode = TileMode.reading,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: context.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          SvgPicture.asset(component.image, height: 40),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  component.name ?? component.comType.getLocalizedName(context),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  component.deviceInfo,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          switch (tileMode) {
            TileMode.reading => ComponentValue(
              component: component,
              uniformSize: true,
            ),
            TileMode.add => _buildAddButton(context),
            TileMode.remove => _buildRemoveButton(),
          },
        ],
      ),
    );
  }

  IconButton _buildRemoveButton() {
    return IconButton(
      icon: const Icon(
        AppIcons.close,
        color: Color.fromARGB(255, 255, 0, 0),
        size: 15,
      ),
      style: IconButton.styleFrom(
        minimumSize: const Size(32, 32),
        backgroundColor: Colors.red.shade100,
      ),
      onPressed: onPressed,
    );
  }

  IconButton _buildAddButton(BuildContext context) {
    return IconButton(
      icon: Icon(AppIcons.add, color: context.colorScheme.tertiary, size: 18),
      style: IconButton.styleFrom(
        minimumSize: const Size(32, 32),
        backgroundColor: context.colorScheme.tertiaryContainer,
      ),
      onPressed: onPressed,
    );
  }
}
