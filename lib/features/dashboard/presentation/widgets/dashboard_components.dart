import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_home/core/constants/images.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';
import 'package:smart_home/core/widgets/error_screen.dart';
import 'package:smart_home/core/widgets/loading_body.dart';
import 'package:smart_home/features/devices/domain/device.dart';
import 'package:smart_home/features/images/presentation/dynamic_image.dart';
import 'package:smart_home/features/rooms/application/rooms_provider.dart';
import 'package:smart_home/features/rooms/domain/room.dart';

import '../../domain/component.dart';
import '../../domain/dashboard_state.dart';
import 'component_container.dart';

class DashboardComponents extends StatelessWidget {
  const DashboardComponents(this.devices, this.layout, {super.key});

  final List<Device> devices;
  final DashboardLayout layout;

  @override
  Widget build(BuildContext context) {
    final components = [for (Device d in devices) ...d.components];
    return SingleChildScrollView(
      child:
          layout == DashboardLayout.grid
              ? _buildDashboardGrid(components)
              : _buildDashboardList(components),
    );
  }

  Widget _buildDashboardGrid(List<Component> components) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: components.length,
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 250,
        childAspectRatio: 1.1,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        return ComponentCard(component: components[index]);
      },
    );
  }

  Widget _buildDashboardList(List<Component> components) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: components.length,
      padding: const EdgeInsets.all(14),
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        return ComponentTile(component: components[index]);
      },
    );
  }
}

class DashboardComponentsByRoom extends DashboardComponents {
  const DashboardComponentsByRoom(super.devices, super.layout, {super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Consumer(
      builder: (context, ref, child) {
        final roomsAsync = ref.watch(roomsProvider);

        return roomsAsync.when(
          loading: () => LoadingBody(l10n.dashboardLoadingComponents),
          error: (error, stackTrace) => StyledError(error: error),
          data: (rooms) {
            final components = [for (Device d in devices) ...d.components];
            final Map<Room?, List<Component>> componentsByRoom = {};
            for (Component c in components) {
              final Room? room = rooms[c.roomId];
              (componentsByRoom[room] ??= []).add(c);
            }
            debugPrint('LOG: Components By Room: $componentsByRoom');

            // Sort room keys to display unassigned components last
            final roomKeys =
                componentsByRoom.keys.toList()..sort((a, b) {
                  if (a == null) return 1; // Unassigned room comes last
                  if (b == null) return -1; // Unassigned room comes last
                  return 0;
                });

            return ListView.builder(
              itemCount: componentsByRoom.length,
              itemBuilder: (context, index) {
                final room = roomKeys[index];
                final roomComponents = componentsByRoom[room]!;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          if (room != null)
                            RoundedImage(
                              imageUrl: room.imageUrl,
                              svgFallback: Images.ROOM_FALLBACK,
                              height: 55,
                            ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              room?.name ?? l10n.dashboardUnassignedRoom,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                    layout == DashboardLayout.grid
                        ? _buildDashboardGrid(roomComponents)
                        : _buildDashboardList(roomComponents),
                    if (index < componentsByRoom.length - 1)
                      const SizedBox(height: 12),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}

class DashboardComponentsByDevice extends DashboardComponents {
  const DashboardComponentsByDevice(super.devices, super.layout, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: devices.length,
      itemBuilder: (context, index) {
        final device = devices[index];
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SvgPicture.asset(Images.ESP32, height: 50),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      device.name ?? device.type,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ],
              ),
            ),
            layout == DashboardLayout.grid
                ? _buildDashboardGrid(device.components)
                : _buildDashboardList(device.components),
            if (index < devices.length - 1) const SizedBox(height: 12),
          ],
        );
      },
    );
  }
}
