import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';
import 'package:smart_home/core/utils/extensions.dart';
import 'package:smart_home/core/widgets/loading_overlay.dart';
import 'package:smart_home/features/devices/application/devices_notifier.dart';

import '../widgets/device_discovery.dart';
import '../widgets/wifi_config.dart';

class NewDeviceScreen extends ConsumerWidget {
  const NewDeviceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!; // Added l10n instance
    final linkingInProgress = ref.watch(linkDeviceInProgressProvider);

    final wifiConfigHeaderText = l10n.newDeviceScreenWifiConfigHeader;
    final deviceDiscoveryHeaderText = l10n.newDeviceScreenDeviceDiscoveryHeader;

    final widget = Scaffold(
      appBar: AppBar(
        title: Text(l10n.newDeviceScreenAppBarTitle),
      ), // Updated text
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            _Header(1, wifiConfigHeaderText), // Updated text
            const SizedBox(height: 10),
            _ConfigContainer(child: WifiConfig()),
            const SizedBox(height: 20),
            _Header(2, deviceDiscoveryHeaderText), // Updated text
            const RefreshButton(),
            const _ConfigContainer(child: DeviceDiscovery()),
            const SizedBox(height: 10),
            Text(
              l10n.newDeviceScreenWifiNetworkNote, // Updated text
              style: TextStyle(color: Theme.of(context).colorScheme.outline),
            ),
          ],
        ),
      ),
    );

    return PopScope(
      canPop: !linkingInProgress,
      child: Stack(
        children: [
          widget,
          if (linkingInProgress)
            LoadingOverlay(
              message: l10n.newDeviceScreenLinkingDeviceProgress,
            ), // Updated text
        ],
      ),
    );
  }
}

class _ConfigContainer extends StatelessWidget {
  final Widget child;

  const _ConfigContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      color: context.colorScheme.secondaryContainer,
      borderRadius: const BorderRadius.all(Radius.circular(26)),
      child: child,
    );
  }
}

class _Header extends StatelessWidget {
  final int number;
  final String text;

  const _Header(this.number, this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: context.colorScheme.tertiaryContainer,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Center(
            child: Text(
              '$number',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: context.colorScheme.tertiary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Expanded(
          child: Text(text, style: Theme.of(context).textTheme.titleMedium),
        ),
      ],
    );
  }
}
