import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_home/features/images/application/image_picker_provider.dart';
import 'package:smart_home/features/images/presentation/dynamic_image.dart';
import 'package:smart_home/features/images/presentation/image_options.dart';

class AvatarEditor extends ConsumerWidget {
  final String? imageUrl;
  final VoidCallback onClear;

  const AvatarEditor({super.key, this.imageUrl, required this.onClear});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final File? selectedImage = ref.watch(imageControllerProvider);
    final bool clearImageUrl = ref.watch(clearImageUrlProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          RoundedImage(
            imageUrl: clearImageUrl ? null : imageUrl,
            imageFile: selectedImage,
          ),
          const SizedBox(height: 16),
          ImageOptions(onCleared: onClear, isProfile: true),
        ],
      ),
    );
  }
}
