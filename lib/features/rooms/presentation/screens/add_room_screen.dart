import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';
import 'package:smart_home/core/utils/extensions.dart';
import 'package:smart_home/core/utils/text_formatter.dart';
import 'package:smart_home/features/images/domain/loading_state.dart';
import 'package:smart_home/features/profile/presentation/widgets/save_button.dart';
import 'package:smart_home/features/rooms/application/rooms_provider.dart';

import '../widgets/room_form.dart';
import '../widgets/room_image_editor.dart';

class RoomEditorScreen extends ConsumerWidget {
  const RoomEditorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isLoading = ref.watch(addRoomProvider) != LoadingState.none;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.addRoomScreenTitle)),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: IgnorePointer(
              ignoring: isLoading,
              child: Column(
                spacing: 16,
                children: [
                  const RoomImageEditor(),
                  const RoomForm(),
                  SaveButton(
                    isLoading: isLoading,
                    onPressed: () => _onSave(context, ref, l10n),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onSave(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) async {
    try {
      final int id = await ref.read(roomsProvider.notifier).addRoom();
      if (context.mounted) context.pushReplacement('/room', extra: id);
    } catch (error) {
      context.showSnackBar(TextFormatter.getErrorMessage(error, l10n));
    }
  }
}
