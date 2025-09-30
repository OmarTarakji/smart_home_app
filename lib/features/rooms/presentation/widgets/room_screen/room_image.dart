import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_home/core/constants/images.dart';
import 'package:smart_home/features/images/application/image_picker_provider.dart';
import 'package:smart_home/features/images/presentation/dynamic_image.dart';

import '../../../application/rooms_provider.dart';

class RoomImage extends ConsumerWidget {
  final int roomId;

  const RoomImage({required this.roomId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String? imageUrl =
        ref.watch(roomsProvider).requireValue[roomId]?.imageUrl;

    return Hero(
      tag: imageUrl ?? roomId,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        clipBehavior: Clip.antiAlias,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 300),
          child: DynamicImage(
            imageUrl: imageUrl,
            imageFile: ref.watch(imageControllerProvider),
            svgFallback: Images.ROOM_FALLBACK,
            height: 200,
          ),
        ),
      ),
    );
  }
}
