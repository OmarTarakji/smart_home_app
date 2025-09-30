import 'package:flutter/foundation.dart' show debugPrint;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';
import 'package:smart_home/core/utils/text_formatter.dart';
import 'package:smart_home/features/images/domain/loading_state.dart';
import 'package:smart_home/features/rooms/data/rooms_repository.dart';
import 'package:smart_home/features/rooms/presentation/controllers/running_operations_providers.dart';

import '../domain/room.dart';
import 'room_editor_provider.dart';

part 'rooms_provider.g.dart';

@riverpod
class RoomsNotifier extends _$RoomsNotifier {
  final _repo = RoomsRepository();
  @override
  Future<Map<int, Room>> build() async {
    ref.keepAlive();
    try {
      // Fetch rooms list
      final rooms = await _repo.getUserRooms();
      debugPrint('log: Built rooms notifier');
      return rooms;
    } catch (e) {
      // Start auto-reload if initial load fails
      debugPrint('log: Failed to load Rooms, starting auto-reload');
      _autoReload();
      rethrow;
    }
  }

  void _autoReload() async {
    while (true) {
      try {
        debugPrint('log: Loading rooms...');
        final rooms = await _repo.getUserRooms();
        state = AsyncData(rooms);
        break;
      } catch (e) {
        debugPrint('log: Error loading rooms, Scheduling for auto-reload');
        await Future.delayed(const Duration(seconds: 5));
      }
    }
  }

  /// Reload without a loading state
  /// Use case: pull down to get the latest rooms list from the database
  Future<void> refresh() async {
    state = await AsyncValue.guard(_repo.getUserRooms);
  }

  /// Reload with a loading state
  /// Use case: In case of error reload the screen
  // Future<void> reload() async {
  //   state = const AsyncValue.loading();
  //   await refresh();
  // }
  //
  // /// Only update the state on success
  // /// Use case: Automatically and silently reload data in error screen
  // Future<void> autoReload() async {
  //   try {
  //     state = AsyncData(await _repo.getUserRooms());
  //   } catch (e, _) {
  //     debugPrint('log: Failed to auto reload rooms');
  //   }
  // }

  Future<String?> deleteRoom(int id, AppLocalizations l10n) async {
    try {
      await _repo.deleteRoom(id);
      final map = Map<int, Room>.from(state.requireValue);
      map.remove(id);
      state = AsyncData(map);
    } catch (e) {
      return TextFormatter.getErrorMessage(e, l10n);
    } finally {
      refresh();
    }
    return null;
  }

  Future<int> addRoom() async {
    ref.read(addRoomProvider.notifier).setState(LoadingState.loading);
    try {
      final String name = ref.read(roomFormControllerProvider.notifier).save();
      final url = await ref.read(roomImageControllerProvider.notifier).url();

      final room = Room(name: name, imageUrl: url);

      final id = await _repo.addRoom(room);
      state = AsyncData({...state.requireValue, id: room});
      return id;
    } catch (error) {
      ref.read(addRoomProvider.notifier).setState(LoadingState.none);
      rethrow;
    }
  }

  Future<void> renameRoom(int roomId, String newName) async {
    try {
      ref.read(renameRoomLoadingStateProvider.notifier).setState(true);
      await _repo.renameRoom(roomId, newName);
      final map = Map<int, Room>.from(state.requireValue);
      map[roomId] = map[roomId]!.copyWith(name: newName);
      state = AsyncData(map);
    } finally {
      ref.read(renameRoomLoadingStateProvider.notifier).setState(false);
    }
  }
}

@riverpod
class AddRoom extends _$AddRoom {
  @override
  LoadingState build() {
    return LoadingState.none;
  }

  void setState(LoadingState state) => this.state = state;
}
