import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';
import 'package:smart_home/core/utils/exceptions.dart';
import 'package:smart_home/core/utils/extensions.dart';
import 'package:smart_home/core/widgets/vertical_button.dart';

import '../application/image_picker_provider.dart';

class ImageOptions extends ConsumerWidget {
  final VoidCallback? onCleared;
  final VoidCallback? onPicked;
  final bool isProfile;
  const ImageOptions({
    this.onPicked,
    this.onCleared,
    this.isProfile = false,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    Future<void> pickImage(ImageSource source) async {
      try {
        final imagePicked = await ref
            .read(imageControllerProvider.notifier)
            .pickImage(source, isProfile: isProfile);
        if (onPicked != null && imagePicked) onPicked!();
      } on ImagePickerException catch (e) {
        if (context.mounted) context.showErrorSnackBar(e.message);
      }
    }

    void clearImage() {
      if (onCleared != null) onCleared!();
      ref.read(imageControllerProvider.notifier).clear();
    }

    return Row(
      children: [
        Expanded(
          child: VerticalButton(
            icon: Icons.camera_alt_outlined,
            label: l10n.imageOptionsCameraButton,
            onPressed: () => pickImage(ImageSource.camera),
            background: context.colorScheme.secondaryContainer,
          ),
        ),
        Expanded(
          child: VerticalButton(
            icon: Icons.image_outlined,
            label: l10n.imageOptionsGalleryButton,
            onPressed: () => pickImage(ImageSource.gallery),
            background: context.colorScheme.secondaryContainer,
          ),
        ),
        Expanded(
          child: VerticalButton(
            icon: Icons.not_interested,
            label: l10n.imageOptionsRemoveButton,
            onPressed: clearImage,
            background: context.colorScheme.secondaryContainer,
          ),
        ),
      ],
    );
  }
}
