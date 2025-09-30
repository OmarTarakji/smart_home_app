import 'package:flutter/material.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';
import 'package:smart_home/core/utils/extensions.dart';
import 'package:smart_home/features/dashboard/domain/component.dart';

import '../../domain/udp_device.dart';

class UdpDeviceDetails extends StatelessWidget {
  final UdpDevice device;

  const UdpDeviceDetails(this.device, {super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.wifi_rounded),
          title: Text(l10n.deviceDetailsMacAddressLabel),
          subtitle: Text(device.macAddress),
          dense: true,
        ),
        ListTile(
          leading: const Icon(Icons.router_rounded),
          title: Text(l10n.udpDeviceDetailsIpAddressLabel),
          subtitle: Text(device.ipAddress),
          dense: true,
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.sensors_rounded),
          title: Text(l10n.deviceDetailsSensorsLabel),
          trailing: _buildCountContainer(context, device.sensors.length),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
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
                  title: Text(s.name ?? s.comType.getLocalizedName(context)),
                ),
            ],
          ),
        ),
        ListTile(
          leading: const Icon(Icons.settings_rounded),
          title: Text(l10n.deviceDetailsControlsLabel),
          trailing: _buildCountContainer(context, device.controls.length),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
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
                  title: Text(c.name ?? c.comType.getLocalizedName(context)),
                ),
            ],
          ),
        ),
      ],
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
