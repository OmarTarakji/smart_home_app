import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_home/core/constants/images.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';
import 'package:smart_home/features/devices/application/devices_notifier.dart';
import 'package:smart_home/features/devices/presentation/widgets/udp_device_details.dart';

import '../../domain/udp_device.dart';

class LinkDeviceModal extends ConsumerWidget {
  final UdpDevice device;

  const LinkDeviceModal({required this.device, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!; // Added l10n instance
    final isOwned = ref
        .read(devicesProvider.notifier)
        .isOwned(device.macAddress);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Stack(
          children: [
            Scrollbar(
              thickness: 6,
              radius: const Radius.circular(5),
              interactive: true,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    buildDeviceHeader(isOwned, context, l10n), // Pass l10n
                    UdpDeviceDetails(device),
                    SizedBox(height: (isOwned) ? 20 : 70),
                  ],
                ),
              ),
            ),
            if (!isOwned)
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 12),
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => context.pop(true),
                    child: Text(l10n.linkDeviceModalLinkButton), // Updated text
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildDeviceHeader(
    bool isOwned,
    BuildContext context,
    AppLocalizations l10n,
  ) {
    // Added l10n parameter
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(40),
          child: SvgPicture.asset(Images.ESP32, height: 120),
        ),
        Text(
          device.type,
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        if (isOwned)
          Text(
            l10n.linkDeviceModalAlreadyLinked, // Updated text
            style: const TextStyle(color: Colors.green),
          ),
      ],
    );
  }
}
