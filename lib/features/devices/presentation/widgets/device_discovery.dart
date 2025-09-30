import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_home/core/constants/images.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';
import 'package:smart_home/core/theme/app_colors.dart';
import 'package:smart_home/core/utils/exceptions.dart';
import 'package:smart_home/core/utils/extensions.dart';
import 'package:smart_home/core/utils/text_formatter.dart';

import '../../application/devices_notifier.dart';
import '../../application/udp_service_provider.dart';
import '../../domain/udp_device.dart';
import '../screens/link_device_modal.dart';

class DeviceDiscovery extends ConsumerWidget {
  const DeviceDiscovery({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final devices = ref.watch(deviceDiscoveryProvider);
    debugPrint('Devices: ${devices.toString()}');

    return SizedBox(
      height: devices.length < 3 ? 217.5 : (devices.length + 1) * 72.5,
      child:
          (devices.isEmpty)
              ? const _EmptyDiscoveryList()
              : Column(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder:
                        (context, index) =>
                            _buildDeviceTile(devices[index], context, ref),
                    separatorBuilder:
                        (_, _) => Divider(
                          height: 1,
                          color: context.colorScheme.outlineVariant.withAlpha(
                            100,
                          ),
                        ),
                    itemCount: devices.length,
                  ),
                  Divider(
                    height: 1,
                    color: context.colorScheme.outlineVariant.withAlpha(100),
                  ),
                ],
              ),
    );
  }

  ListTile _buildDeviceTile(UdpDevice device, BuildContext ctx, WidgetRef ref) {
    final l10n = AppLocalizations.of(ctx)!;
    return ListTile(
      leading: SvgPicture.asset(Images.ESP32, height: 40),
      title: Text(device.type),
      subtitle: Text(l10n.deviceDiscoveryMacAddressLabel + device.macAddress),
      onTap: () => _previewDevice(device, ctx, ref),
      trailing: const Icon(Icons.chevron_right),
    );
  }

  void _previewDevice(
    UdpDevice device,
    BuildContext context,
    WidgetRef ref,
  ) async {
    final l10n = AppLocalizations.of(context)!;

    final localRef = ref;
    bool wantsToLink =
        await showModalBottomSheet(
          context: context,
          useSafeArea: true,
          isScrollControlled: true,
          builder: (_) => LinkDeviceModal(device: device),
        ) ??
        false;

    if (wantsToLink) {
      try {
        localRef.read(linkDeviceInProgressProvider.notifier).setTrue();
        await localRef.read(devicesProvider.notifier).linkDevice(device);

        if (context.mounted) {
          context.showSnackBar(l10n.deviceDiscoveryLinkedSuccess);
          context.pop();
        }
      } on DeviceException catch (e) {
        if (context.mounted) {
          context.showErrorDialog(
            l10n.deviceDiscoveryLinkFailedTitle,
            e.message,
          );
        }
      } catch (e) {
        final message = TextFormatter.getErrorMessage(e, l10n);
        if (context.mounted) context.showErrorSnackBar(message);
      } finally {
        localRef.read(linkDeviceInProgressProvider.notifier).setFalse();
      }
    }
  }
}

class RefreshButton extends ConsumerWidget {
  const RefreshButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isLoading = ref.watch(discoveryLoadingStateProvider);
    return Row(
      children: [
        const Spacer(),
        if (isLoading)
          const SizedBox(
            width: 26,
            height: 26,
            child: CircularProgressIndicator(),
          ),
        MaterialButton(
          onPressed: ref.read(deviceDiscoveryProvider.notifier).refresh,
          padding: const EdgeInsets.symmetric(vertical: 2),
          textColor: context.colorScheme.primary,
          child: Text(l10n.deviceDiscoveryRefreshButton),
        ),
      ],
    );
  }
}

class _EmptyDiscoveryList extends ConsumerWidget {
  const _EmptyDiscoveryList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final int failedAttempts = ref.watch(reloadAttemptsProvider);
    return Column(
      spacing: 12,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.search_off, size: 50),
        Text(
          l10n.deviceDiscoveryNoDevicesFound,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        if (failedAttempts >= 3)
          Text(
            l10n.deviceDiscoveryVpnWarning,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(color: AppColors.warning),
          ),
      ],
    );
  }
}
