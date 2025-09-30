import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';
import 'package:smart_home/core/widgets/error_screen.dart';
import 'package:smart_home/features/rooms/presentation/widgets/add_room_button.dart';

import '../../application/rooms_provider.dart';
import '../widgets/room_item.dart';

class RoomsScreen extends ConsumerWidget {
  static const _padding = 8.0;
  static const _maxExtent = 250.0;

  const RoomsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final roomsAsync = ref.watch(roomsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.roomsScreenTitle),
        actions: [
          TextButton.icon(
            onPressed:
                roomsAsync.hasValue ? () => context.push('/add-room') : null,
            icon: const Icon(Icons.add),
            label: Text(l10n.roomsScreenAddRoomButton),
          ),
        ],
      ),
      body: roomsAsync.when(
        data: (rooms) {
          final List<int> keys = rooms.keys.toList();
          debugPrint('log: rooms number ${rooms.length}');
          return LayoutBuilder(
            builder: (context, constraints) {
              final diameter = _calcDiameter(constraints);
              return GridView.builder(
                itemCount: rooms.length + 1,
                padding: const EdgeInsets.all(_padding),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: _maxExtent,
                  childAspectRatio: _calcRatio(diameter),
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  if (index < rooms.length) {
                    return RoomItem(
                      id: keys[index],
                      room: rooms[keys[index]]!,
                      padding: _padding,
                      diameter: diameter,
                    );
                  } else {
                    return AddRoomButton(
                      radius: diameter / 2,
                      padding: _padding,
                      onTap: () => context.push('/add-room'),
                    );
                  }
                },
              );
            },
          );
        },
        error: (error, stackTrace) => StyledError(error: error),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  double _calcDiameter(BoxConstraints constraints) {
    final availableWidth = constraints.maxWidth - _padding * 2;
    final crossAxisItemsCount = (availableWidth / _maxExtent).ceil();
    final itemWidth = availableWidth / crossAxisItemsCount;
    return itemWidth - 2 * _padding;
  }

  double _calcRatio(double diameter) {
    final width = diameter + _padding * 2;
    final height = width + 36; // imageHeight + spacing + textHeight
    return width / height;
  }
}
