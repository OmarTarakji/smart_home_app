import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';
import 'package:smart_home/core/utils/extensions.dart';
import 'package:smart_home/core/utils/text_formatter.dart';
import 'package:smart_home/features/rooms/presentation/screens/components_picker.dart';
import 'package:smart_home/features/rooms/presentation/widgets/room_screen/component_tile.dart';

import '../../../application/room_providers.dart';

class RoomComponents extends ConsumerWidget {
  final int roomId;

  const RoomComponents({required this.roomId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final comsAsync = ref.watch(roomComponentsProvider(roomId));
    return comsAsync.when(
      data: (coms) {
        debugPrint('log: $coms');
        if (coms.isEmpty) {
          return AddComponentButton(roomId: roomId);
        } else {
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: coms.length,
            separatorBuilder: (context, index) => const SizedBox(height: 14),
            itemBuilder: (context, index) => ComTile(component: coms[index]),
          );
        }
      },
      error: (error, stackTrace) {
        final message = TextFormatter.getErrorMessage(error, l10n);

        return Column(
          spacing: 20,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 100,
              color: Theme.of(context).colorScheme.error,
            ),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const CircularProgressIndicator(),
          ],
        );
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class AddComponentButton extends StatelessWidget {
  final int roomId;

  const AddComponentButton({required this.roomId, super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return InkWell(
      borderRadius: BorderRadius.circular(24),
      splashColor: context.colorScheme.secondaryContainer,
      onTap: () => showComponentsPicker(context, roomId),
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          radius: const Radius.circular(24),
          color: context.colorScheme.secondary,
          dashPattern: const [8, 6],
          borderPadding: const EdgeInsets.all(2),
          strokeWidth: 4,
        ),
        child: SizedBox(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, size: 40, color: context.colorScheme.secondary),
              const SizedBox(width: 6),
              Text(
                l10n.add,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: context.colorScheme.secondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
