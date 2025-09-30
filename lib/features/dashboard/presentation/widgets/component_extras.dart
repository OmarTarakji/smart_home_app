import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_home/core/constants/images.dart';
import 'package:smart_home/core/utils/extensions.dart';
import 'package:smart_home/features/images/presentation/dynamic_image.dart';
import 'package:smart_home/features/rooms/application/rooms_provider.dart';

class ComponentExtras extends ConsumerWidget {
  const ComponentExtras(this.roomId, this.device, {super.key});

  final int? roomId;
  final String device;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomsAsync = ref.watch(roomsProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            const SizedBox(width: 10),
            Icon(
              Icons.info_outline,
              size: 16,
              color: context.colorScheme.outline,
            ),
            const SizedBox(width: 6),
            Text(
              'info',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: context.colorScheme.outline,
              ),
            ),
            const SizedBox(width: 10),
            const Expanded(child: Divider(height: 1)),
            const SizedBox(width: 20),
          ],
        ),
        if (roomId != null) const SizedBox(height: 20),
        roomsAsync.when(
          error: (error, stackTrace) => const SizedBox(),
          loading: () => const SizedBox(),
          data: (rooms) {
            final room = rooms[roomId];
            if (room != null) {
              return InkWell(
                onTap: () => context.push('/room', extra: roomId),
                child: Row(
                  children: [
                    RoundedImage(
                      imageUrl: room.imageUrl,
                      svgFallback: Images.ROOM_FALLBACK,
                      height: 50,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        room.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),

        const SizedBox(height: 20),
        Row(
          children: [
            SvgPicture.asset(Images.ESP32, height: 46),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                device,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
