import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../data/notifications_repository.dart';
import '../domain/notification_model.dart';

part 'notifications_provider.g.dart';

@riverpod
class NotificationsNotifier extends _$NotificationsNotifier {
  late final _repo = NotificationsRepository();

  @override
  Future<List<NotificationModel>> build() async {
    ref.keepAlive();
    try {
      final notifications = await _repo.fetchNotifications();
      debugPrint('LOG: $notifications');
      return notifications;
    } catch (e) {
      // Start auto-reload if initial load fails
      debugPrint('LOG: Failed to load Notifications, starting auto-reload');
      _autoReload();
      rethrow;
    }
  }

  void _autoReload() async {
    while (true) {
      try {
        debugPrint('LOG: Loading notifications...');
        final profile = await _repo.fetchNotifications();
        state = AsyncData(profile);
        break;
      } catch (e) {
        debugPrint(
          'LOG: Error loading notifications, Scheduling for auto-reload',
        );
        await Future.delayed(const Duration(seconds: 5));
      }
    }
  }

  /// Reload without a loading state (data/error state only).
  /// Use case: Get the latest data set from the database
  Future<void> refresh() async {
    state = await AsyncValue.guard(_repo.fetchNotifications);
    if (state.hasError) _autoReload();
  }

  void onRecordInserted(PostgresChangePayload payload) {
    final insertedRecord = payload.newRecord;
    debugPrint('LOG: $insertedRecord');
    final notification = NotificationModel.fromJson(insertedRecord);
    final previousState = state.asData?.value ?? [];
    // Add the new notification to the beginning of the list
    state = AsyncData([notification, ...previousState]);
  }

  Future<void> markAsRead(int notificationId) async {
    await _repo.markAsRead(notificationId);
    final previousState = state.asData?.value;
    if (previousState != null) {
      state = AsyncData(
        previousState.map((notification) {
          if (notification.id == notificationId) {
            return notification.copyWith(isRead: true);
          }
          return notification;
        }).toList(),
      );
    }
  }

  Future<void> delete(int id) async {
    await _repo.delete(id);
    final previousState = state.asData?.value;
    if (previousState != null) {
      state = AsyncData(
        previousState.where((notification) => notification.id != id).toList(),
      );
    }
  }

  Future<void> deleteAll() async {
    await _repo.deleteAll();
    state = const AsyncData([]);
  }
}

@riverpod
int notificationsCount(Ref ref) {
  final notifications = ref.watch(notificationsProvider).asData?.value;
  if (notifications == null) return 0;
  return notifications.where((notification) => !notification.isRead).length;
}
