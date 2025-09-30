import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';
import 'package:smart_home/core/utils/extensions.dart';
import 'package:smart_home/core/widgets/error_screen.dart';
import 'package:smart_home/core/widgets/loading_body.dart';
import 'package:smart_home/features/dashboard/domain/component.dart';
import 'package:smart_home/features/rooms/application/room_providers.dart';

import '../../domain/filtered_component.dart';
import '../widgets/room_screen/component_tile.dart';

void showComponentsPicker(BuildContext context, int roomId) {
  showModalBottomSheet(
    context: context,
    builder: (context) => ComponentsPicker(roomId: roomId),
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
  );
}

class ComponentsPicker extends ConsumerWidget {
  final int roomId;

  const ComponentsPicker({required this.roomId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final comsAsync = ref.watch(filteredComponentsProvider(roomId));

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            color: context.colorScheme.surface,
          ),
          child: comsAsync.when(
            data: (coms) {
              return Stack(
                children: [
                  _buildBody(scrollController, coms, ref, l10n),
                  _buildHeader(context, l10n),
                ],
              );
            },
            error: (error, stackTrace) => StyledError(error: error),
            loading: () => LoadingBody(l10n.componentsPickerLoadingComponents),
          ),
        );
      },
    );
  }

  Widget _buildBody(
    ScrollController controller,
    FilteredComponents coms,
    WidgetRef ref,
    AppLocalizations l10n,
  ) {
    final componentsNotifier = ref.read(
      filteredComponentsProvider(roomId).notifier,
    );
    if (coms.isEmpty) {
      //TODO: Make a proper empty list widget
      return Center(child: Text(l10n.componentsPickerNoComponentsFound));
    }
    return ListView(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 64, bottom: 16),
      controller: controller,
      children: [
        _buildComponentsList(
          coms.added,
          TileMode.remove,
          componentsNotifier.removeComponent,
          l10n,
        ),
        if (coms.added.isNotEmpty) const SizedBox(height: 24),
        _buildComponentsList(
          coms.available,
          TileMode.add,
          componentsNotifier.addComponent,
          l10n,
        ),
        const SizedBox(height: 14),

        if (coms.unavailable.isNotEmpty)
          ExpansionTile(
            minTileHeight: 30,
            shape: const Border(),
            title: Text(l10n.componentsPickerOtherDevices),
            children: [
              _buildComponentsList(
                coms.unavailable,
                TileMode.add,
                componentsNotifier.addComponent,
                l10n,
              ),
            ],
          ),
        const SizedBox(height: 50),
      ],
    );
  }

  Widget _buildComponentsList(
    List<Component> coms,
    TileMode tileMode,
    Future<String?> Function(Component, AppLocalizations l10n) onPressed,
    AppLocalizations l10n,
  ) {
    debugPrint('log: coms length: ${coms.length}');
    return ListView.separated(
      padding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: coms.length,
      separatorBuilder: (context, index) => const SizedBox(height: 14),
      itemBuilder: (ctx, idx) {
        return ComTile(
          component: coms[idx],
          tileMode: tileMode,
          onPressed: () async {
            final errorMessage = await onPressed(coms[idx], l10n);
            if (errorMessage != null && ctx.mounted) {
              Navigator.pop(ctx);
              ctx.showErrorSnackBar(errorMessage);
            }
          },
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations l10n) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        // height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.5),
          color: context.colorScheme.surface.withAlpha(220),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                l10n.componentsPickerPickComponentsTitle,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
