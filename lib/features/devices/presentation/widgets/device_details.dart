import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_home/core/constants/images.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';
import 'package:smart_home/core/utils/extensions.dart';
import 'package:smart_home/features/dashboard/models/component.dart';

import '../../domain/device.dart';

class DeviceInfoModal extends StatelessWidget {
  final Device device;

  const DeviceInfoModal({required this.device, super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Scrollbar(
          thickness: 6,
          radius: const Radius.circular(5),
          interactive: true,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                SvgPicture.asset(Images.ESP32, height: 120),
                const SizedBox(height: 20),
                Text(
                  device.name?.isEmpty ?? true
                      ? l10n.deviceDetailsUntitledDevice
                      : device.name!,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),

                ListTile(
                  leading: const Icon(Icons.developer_board_rounded),
                  title: Text(l10n.deviceDetailsDeviceTypeLabel),
                  subtitle: Text(device.type),
                  dense: true,
                ),
                ListTile(
                  leading: const Icon(Icons.wifi_rounded),
                  title: Text(l10n.deviceDetailsMacAddressLabel),
                  subtitle: Text(device.macAddress),
                  dense: true,
                ),
                ListTile(
                  leading: const Icon(Icons.calendar_month),
                  title: Text(l10n.deviceDetailsDateAddedLabel),
                  subtitle: Text(device.getFormattedDateTime()),
                  dense: true,
                ),
                ListTile(
                  leading: const Icon(Icons.sensors_rounded),
                  title: Text(l10n.deviceDetailsSensorsLabel),
                  trailing: _buildCountContainer(
                    context,
                    device.sensors.length,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: context.colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                      for (Component s in device.sensors)
                        ListTile(
                          dense: true,
                          leading: Icon(s.comType.icon),
                          title: Text(
                            s.name ?? s.comType.getLocalizedName(context),
                          ),
                        ),
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.settings_rounded),
                  title: Text(l10n.deviceDetailsControlsLabel),
                  trailing: _buildCountContainer(
                    context,
                    device.controls.length,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: context.colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                      for (Component c in device.controls)
                        ListTile(
                          dense: true,
                          leading: Icon(c.comType.icon),
                          title: Text(
                            c.name ?? c.comType.getLocalizedName(context),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _buildCountContainer(BuildContext context, int count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '$count',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: context.colorScheme.onTertiaryContainer,
        ),
      ),
    );
  }
}
