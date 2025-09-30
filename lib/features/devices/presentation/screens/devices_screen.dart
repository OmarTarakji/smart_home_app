import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';
import 'package:smart_home/core/utils/extensions.dart';
import 'package:smart_home/core/widgets/error_screen.dart';
import 'package:smart_home/core/widgets/loading_body.dart';
import 'package:smart_home/features/devices/domain/device.dart';

import '../../application/devices_notifier.dart';
import '../widgets/device_quick_options.dart';

class DevicesScreen extends ConsumerWidget {
  const DevicesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final devicesAsync = ref.watch(devicesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.devicesScreenTitle),
        actions: [
          TextButton.icon(
            label: Text(l10n.devicesScreenAddDeviceButton),
            icon: const Icon(Icons.add),
            onPressed:
                devicesAsync.hasValue
                    ? () => context.push('/add-device')
                    : () => context.showSnackBar(
                      l10n.devicesScreenNeedInternetAccess,
                    ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: ref.read(devicesProvider.notifier).refresh,
        child: devicesAsync.when(
          data: (data) {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder:
                  (ctx, idx) => _deviceBuilder(ctx, data[idx], idx, l10n),
            );
          },
          loading: () => LoadingBody(l10n.devicesScreenLoadingList),
          error: (error, stackTrace) {
            return Center(
              child: StyledError(error: error, stackTrace: stackTrace),
            );
          },
        ),
      ),
    );
  }

  Widget _deviceBuilder(
    BuildContext context,
    Device device,
    int index,
    AppLocalizations l10n,
  ) {
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: context.colorScheme.secondaryContainer,
      ),
      child: ExpansionTile(
        shape: const Border(),
        leading: SvgPicture.asset('assets/images/ic_esp32.svg', height: 50),
        title: Text(
          device.name?.isEmpty ?? true
              ? l10n.devicesScreenUntitledDevice
              : device.name!,
        ),
        subtitle: Text('${device.type}\n${device.macAddress}'),
        children: [DeviceQuickOptions(index: index, device: device)],
      ),
    );
  }
}
