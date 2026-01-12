import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_home/core/constants/images.dart';
import 'package:smart_home/features/images/presentation/dynamic_image.dart';
import 'package:smart_home/features/rooms/domain/room.dart';

class RoomItem extends StatelessWidget {
  final int id;
  final Room room;
  final double padding;
  final double diameter;

  const RoomItem({
    required this.id,
    required this.room,
    required this.padding,
    required this.diameter,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go('/rooms/$id'),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Hero(
              tag: room.imageUrl ?? id,
              child: RoundedImage(
                height: diameter,
                imageUrl: room.imageUrl,
                svgFallback: Images.ROOM_FALLBACK,
              ),
            ),
            Text(
              room.name,
              style: Theme.of(context).textTheme.bodyLarge,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
