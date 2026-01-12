import 'package:flutter/material.dart';
import 'package:smart_home/core/l10n/app_localizations.dart'; // Import AppLocalizations
import 'package:smart_home/core/utils/smart_home_icons.dart';

import '../../models/dashboard_state.dart';

class DashboardOptions extends StatefulWidget {
  const DashboardOptions(this.dashboardState, {super.key});

  final DashboardState dashboardState;

  @override
  State<DashboardOptions> createState() => _DashboardOptionsState();
}

class _DashboardOptionsState extends State<DashboardOptions> {
  late DashboardState dashboardState = widget.dashboardState;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!; // Get AppLocalizations instance
    return Padding(
      padding: const EdgeInsets.only(
        top: 16.0,
        left: 12,
        right: 12,
        bottom: 12,
      ),
      child: ListView(
        // mainAxisSize: MainAxisSize.min,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Text(
            l10n.dashboardOptionsLayout,
            style: Theme.of(context).textTheme.bodySmall,
          ), // Use localization key
          SegmentedButton<DashboardLayout>(
            style: SegmentedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              selectedForegroundColor: Theme.of(context).colorScheme.onPrimary,
              selectedBackgroundColor: Theme.of(context).colorScheme.primary,
            ),
            showSelectedIcon: false,
            segments: <ButtonSegment<DashboardLayout>>[
              ButtonSegment<DashboardLayout>(
                value: DashboardLayout.grid,
                label: Text(
                  l10n.dashboardOptionsLayoutGrid,
                ), // Use localization key
                icon: const Icon(Icons.grid_view_rounded),
              ),
              ButtonSegment<DashboardLayout>(
                value: DashboardLayout.list,
                label: Text(
                  l10n.dashboardOptionsLayoutList,
                ), // Use localization key
                icon: const Icon(Icons.menu),
              ),
            ],
            selected: {dashboardState.layout},
            onSelectionChanged: (selection) {
              setState(() {
                dashboardState = dashboardState.copyWith(
                  layout: selection.first,
                );
              });
            },
          ),
          const SizedBox(height: 16),
          Text(
            l10n.dashboardOptionsGroupBy,
            style: Theme.of(context).textTheme.bodySmall,
          ), // Use localization key
          SegmentedButton(
            style: SegmentedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              selectedForegroundColor: Theme.of(context).colorScheme.onPrimary,
              selectedBackgroundColor: Theme.of(context).colorScheme.primary,
            ),
            showSelectedIcon: false,
            segments: [
              ButtonSegment(
                value: DashboardGroupBy.none,
                label: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    l10n.dashboardOptionsGroupByNone,
                    maxLines: 1,
                  ), // Use localization key
                ),
                icon: const Icon(Icons.close),
              ),
              ButtonSegment(
                value: DashboardGroupBy.byRoom,
                label: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    l10n.dashboardOptionsGroupByRoom,
                    maxLines: 1,
                  ), // Use localization key
                ),
                icon: const Icon(AppIcons.room),
              ),
              ButtonSegment(
                value: DashboardGroupBy.byDevice,
                label: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    l10n.dashboardOptionsGroupByDevice,
                    maxLines: 1,
                  ), // Use localization key
                ),
                icon: const Icon(AppIcons.chip),
              ),
            ],
            selected: {dashboardState.groupBy},
            onSelectionChanged: (selection) {
              setState(() {
                dashboardState = dashboardState.copyWith(
                  groupBy: selection.first,
                );
              });
            },
          ),
          const SizedBox(height: 16),
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop(dashboardState);
              },
              child: Text(
                l10n.dashboardOptionsButtonOK,
              ), // Use localization key
            ),
          ),
        ],
      ),
    );
  }
}
