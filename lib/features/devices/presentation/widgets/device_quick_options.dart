import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';
import 'package:smart_home/core/utils/extensions.dart';
import 'package:smart_home/core/utils/text_formatter.dart';
import 'package:smart_home/core/widgets/confirm_delete_dialog.dart';
import 'package:smart_home/core/widgets/vertical_button.dart';

import '../../application/devices_notifier.dart';
import '../../domain/device.dart';
import 'device_details.dart';

class DeviceQuickOptions extends ConsumerWidget {
  final int index;
  final Device device;
  const DeviceQuickOptions({
    required this.index,
    required this.device,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth / 3;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            VerticalButton(
              icon: Icons.edit_outlined,
              label: l10n.deviceQuickOptionsEditButton,
              width: width,
              color: context.colorScheme.primary,
              onPressed: () => onEdit(context, ref),
            ),
            VerticalButton(
              icon: Icons.info_outline_rounded,
              label: l10n.deviceQuickOptionsInfoButton,
              width: width,
              color: context.colorScheme.outline,
              onPressed: () => onInfo(context, ref),
            ),
            VerticalButton(
              icon: Icons.delete_outline_rounded,
              label: l10n.deviceQuickOptionsUnlinkButton,
              width: width,
              color: context.colorScheme.error,
              onPressed: () => onUnlink(context, ref),
            ),
          ],
        );
      },
    );
  }

  void onUnlink(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;

    final bool delete =
        await showDialog(
          context: context,
          builder:
              (context) => ConfirmDeleteDialog(
                title: l10n.deviceQuickOptionsUnlinkDialogTitle(
                  device.name ?? device.type,
                ),
                message: l10n.deviceQuickOptionsUnlinkDialogMessage,
                confirmText: l10n.deviceQuickOptionsUnlinkDialogConfirmButton,
              ),
        ) ??
        false;
    if (delete == false) return;
    try {
      await ref.read(devicesProvider.notifier).unlinkDevice(index);
      if (context.mounted) {
        context.showSnackBar(l10n.deviceQuickOptionsUnlinkSuccessSnackbar);
      }
    } catch (e) {
      final message = TextFormatter.getErrorMessage(e, l10n);
      if (context.mounted) context.showErrorSnackBar(message);
    }
  }

  void onEdit(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;

    final String? newName = await showDialog(
      context: context,
      builder: (context) => RenameDeviceDialog(index, device.name),
    );
    if (newName == null || newName == device.name) return;
    try {
      await ref.read(devicesProvider.notifier).renameDevice(index, newName);
      if (context.mounted) {
        context.showSnackBar(
          l10n.deviceQuickOptionsRenameSuccessSnackbar(newName),
        );
      }
    } catch (e) {
      final message = TextFormatter.getErrorMessage(e, l10n);
      if (context.mounted) context.showErrorSnackBar(message);
    }
  }

  void onInfo(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (_) => DeviceInfoModal(device: device),
    );
  }
}

class RenameDeviceDialog extends StatefulWidget {
  const RenameDeviceDialog(this.index, this.name, {super.key});

  final int index;
  final String? name;

  @override
  State<RenameDeviceDialog> createState() => _RenameDeviceDialogState();
}

class _RenameDeviceDialogState extends State<RenameDeviceDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.name);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(l10n.deviceQuickOptionsRenameDialogTitle),
      content: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: l10n.deviceQuickOptionsRenameDialogHint,
          suffixIcon: IconButton(
            onPressed: _controller.clear,
            icon: const Icon(Icons.close),
          ),
        ),
        maxLength: 50,
      ),
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: Text(l10n.deviceQuickOptionsRenameDialogCancelButton),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, _controller.text),
          child: Text(l10n.deviceQuickOptionsRenameDialogSaveButton),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
