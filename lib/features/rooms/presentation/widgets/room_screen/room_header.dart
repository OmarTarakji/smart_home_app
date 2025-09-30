import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';
import 'package:smart_home/core/utils/extensions.dart';
import 'package:smart_home/core/utils/smart_home_icons.dart';
import 'package:smart_home/core/utils/text_formatter.dart';
import 'package:smart_home/features/rooms/presentation/screens/components_picker.dart';

import '../../../application/rooms_provider.dart';
import '../../../domain/room.dart';
import '../../controllers/running_operations_providers.dart';
import 'delete_room_dialog.dart';
import 'rename_room_dialog.dart';
import 'room_popup_menu.dart';

class RoomHeader extends ConsumerWidget {
  final int roomId;

  const RoomHeader({required this.roomId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final Room? room = ref.watch(roomsProvider).requireValue[roomId];
    final isBusy = ref.watch(runningOperationsProvider) != 0;

    if (room == null) return _buildFallback(context, l10n);

    return Row(
      children: [
        Expanded(
          child: Text(
            room.name,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Consumer(
          builder: (context, ref, child) {
            final isLoading = ref.watch(renameRoomLoadingStateProvider);
            return isLoading
                ? const SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(strokeWidth: 5),
                )
                : const SizedBox();
          },
        ),
        isBusy
            ? const CircularProgressIndicator()
            : IconButton(
              icon: const Icon(AppIcons.dashboard, size: 19),
              style: IconButton.styleFrom(
                backgroundColor: context.colorScheme.secondaryContainer,
                disabledBackgroundColor: context.colorScheme.secondaryContainer,
              ),
              onPressed: () => showComponentsPicker(context, roomId),
            ),
        RoomPopupMenu(
          onRename: () => _onRename(context, room.name, ref, l10n),
          onDelete: () => _onDelete(context, room.name, ref, l10n),
          onGallery: () {},
          onCamera: () {},
        ),
      ],
    );
  }

  Widget _buildFallback(BuildContext context, AppLocalizations l10n) => Column(
    spacing: 20,
    children: [
      const SizedBox(height: 50),
      const Icon(Icons.error_outline_rounded, size: 130),
      Text(
        l10n.fallbackSomethingWentWrong,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    ],
  );

  void _onDelete(
    BuildContext context,
    String name,
    WidgetRef ref,
    AppLocalizations l10n,
  ) async {
    // 1. Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => DeleteRoomDialog(name: name),
    );

    if (confirmed != true) return;

    // 2. Show blocking progress dialog
    if (!context.mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const DeleteLoadingDialog(),
    );

    // 3. Perform deletion
    final error = await ref
        .read(roomsProvider.notifier)
        .deleteRoom(roomId, l10n);

    if (!context.mounted) return;

    // 4. Close all dialogs (using root navigator)
    Navigator.of(context, rootNavigator: true).pop();

    // 5. Handle result
    if (error == null) {
      context.go('/rooms');
      context.showSnackBar(l10n.roomDeletedSuccess(name));
    } else {
      context.showErrorSnackBar(l10n.actionFailedError(error));
    }
  }

  void _onRename(
    BuildContext context,
    String name,
    WidgetRef ref,
    AppLocalizations l10n,
  ) async {
    final String? newName = await showDialog(
      context: context,
      builder: (context) => RenameRoomDialog(name),
    );

    if (newName == null) return;

    try {
      await ref.read(roomsProvider.notifier).renameRoom(roomId, newName);
    } catch (error) {
      context.showErrorSnackBar(TextFormatter.getErrorMessage(error, l10n));
    }
  }
}
