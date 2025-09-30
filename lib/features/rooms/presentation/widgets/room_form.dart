import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';
import 'package:smart_home/features/rooms/application/room_editor_provider.dart';

class RoomForm extends ConsumerWidget {
  const RoomForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final formKey = ref.watch(roomFormControllerProvider);
    final controller = ref.read(roomFormControllerProvider.notifier);

    return Form(
      key: formKey,
      child: TextFormField(
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          labelText: l10n.deviceQuickOptionsRenameDialogHint,
        ),
        maxLength: 25,
        validator: controller.nameValidator,
        onSaved: controller.saveName,
      ),
    );
  }
}
