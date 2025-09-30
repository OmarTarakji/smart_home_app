import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_home/core/l10n/app_localizations.dart'; // Import AppLocalizations
import 'package:smart_home/core/utils/extensions.dart';
import 'package:smart_home/core/widgets/error_screen.dart';
import 'package:smart_home/core/widgets/loading_body.dart';
import 'package:smart_home/features/devices/application/devices_notifier.dart';
import 'package:smart_home/features/notifications/application/notifications_provider.dart';

import '../../application/readings_provider.dart';
import '../../domain/dashboard_state.dart';
import '../controllers/dashboard_screen_providers.dart';
import '../widgets/dashboard_components.dart';
import '../widgets/dashboard_options.dart';
import '../widgets/state_indicator.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final screenState = ref.watch(dashboardStateProvider);
    final stateNotifier = ref.read(dashboardStateProvider.notifier);
    final devicesAsync = ref.watch(devicesProvider);

    return Scaffold(
      appBar: _buildAppBar(context, screenState, stateNotifier, l10n),
      body: devicesAsync.when(
        loading: () => LoadingBody(l10n.dashboardLoadingComponents),
        error: (error, _) => Center(child: StyledError(error: error)),
        data: (devices) {
          return RefreshIndicator(
            onRefresh: () async {
              await ref.read(devicesProvider.notifier).refresh();
              ref.invalidate(readingsProvider);
            },
            child:
                devices.isEmpty
                    ? Center(child: Text(l10n.dashboardNoComponentsFound))
                    : Stack(
                      children: [
                        screenState.groupBy == DashboardGroupBy.byRoom
                            ? DashboardComponentsByRoom(
                              devices,
                              screenState.layout,
                            )
                            : screenState.groupBy == DashboardGroupBy.byDevice
                            ? DashboardComponentsByDevice(
                              devices,
                              screenState.layout,
                            )
                            : DashboardComponents(devices, screenState.layout),
                        const StateIndicator(),
                      ],
                    ),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(
    BuildContext context,
    DashboardState screenState,
    DashboardStateNotifier stateNotifier,
    AppLocalizations l10n,
  ) {
    return AppBar(
      title: Text(l10n.dashboard),
      actions: [
        Consumer(
          builder: (context, ref, child) {
            final notificationsCount = ref.watch(notificationsCountProvider);
            debugPrint('LOG: Notifications count $notificationsCount');
            return Stack(
              children: [
                IconButton(
                  onPressed: () => context.push('/notifications'),
                  icon: const Icon(Icons.notifications),
                ),
                if (notificationsCount > 0)
                  Positioned(
                    right: 3,
                    top: 4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: context.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        '$notificationsCount',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: context.colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
        IconButton(
          onPressed: () async {
            final newState = await showDialog<DashboardState>(
              context: context,
              builder: (context) {
                return Dialog(child: DashboardOptions(screenState));
              },
            );
            if (newState != null) stateNotifier.setState(newState);
          },
          icon: const Icon(Icons.sort),
        ),
      ],
    );
  }
}
