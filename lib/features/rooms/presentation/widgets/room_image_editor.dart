import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_home/core/constants/images.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';
import 'package:smart_home/core/utils/extensions.dart';
import 'package:smart_home/features/images/application/image_picker_provider.dart';
import 'package:smart_home/features/images/domain/loading_state.dart';
import 'package:smart_home/features/images/presentation/dynamic_image.dart';
import 'package:smart_home/features/images/presentation/image_options.dart';

import '../../application/room_editor_provider.dart';

class RoomImageEditor extends ConsumerWidget {
  const RoomImageEditor({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final File? selectedImage = ref.watch(imageControllerProvider);
    final imageState = ref.watch(roomImageControllerProvider);
    final controller = ref.read(roomImageControllerProvider.notifier);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: context.colorScheme.outline),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 3),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Opacity(
                  opacity: imageState == LoadingState.none ? 1.0 : 0.5,
                  child: DynamicImageEditor(
                    svgFallback: Images.ROOM_FALLBACK,
                    imageFile: selectedImage,
                    height: 200,
                  ),
                ),
                if (imageState == LoadingState.uploading)
                  const SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(strokeWidth: 6),
                  ),
                if (imageState == LoadingState.error)
                  _buildErrorState(context, ref, l10n),
              ],
            ),
          ),
          const SizedBox(height: 5),
          IgnorePointer(
            ignoring: imageState == LoadingState.uploading,
            child: ImageOptions(
              onPicked: controller.uploadImage,
              onCleared: controller.clearImage,
            ),
          ),
        ],
      ),
    );
  }

  Column _buildErrorState(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 12,
      children: [
        Icon(
          Icons.error_outline_rounded,
          color: context.colorScheme.error,
          size: 75,
        ),
        Text(
          l10n.roomImageEditorUploadFailed,
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.apply(color: context.colorScheme.error),
        ),
        ElevatedButton.icon(
          onPressed: ref.read(roomImageControllerProvider.notifier).uploadImage,
          label: Text(l10n.roomImageEditorRetryButton),
          icon: const Icon(Icons.refresh),
        ),
      ],
    );
  }
}
