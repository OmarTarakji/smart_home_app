import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';
import 'package:smart_home/core/widgets/error_screen.dart';
import 'package:smart_home/core/widgets/loading_body.dart';
import 'package:smart_home/features/notifications/domain/notification_model.dart';

import '../../application/notifications_provider.dart';
import '../widgets/notification_group.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final notificationsAsync = ref.watch(notificationsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.notificationsScreenTitle)),
      body: notificationsAsync.when(
        data: (notifications) {
          if (notifications.isEmpty) {
            return Center(child: Text(l10n.notificationsScreenNoNotifications));
          }

          final now = DateTime.now();
          final today = <NotificationModel>[];
          final yesterday = <NotificationModel>[];
          final thisWeek = <NotificationModel>[];
          final older = <NotificationModel>[];

          for (final notification in notifications) {
            final notificationDate = notification.timestamp;
            final difference = now.difference(notificationDate).inDays;

            if (difference == 0 && notificationDate.day == now.day) {
              today.add(notification);
            } else if (difference == 1 ||
                (difference == 0 && notificationDate.day == now.day - 1)) {
              yesterday.add(notification);
            } else if (difference < 7 &&
                notificationDate.weekday <= now.weekday) {
              thisWeek.add(notification);
            } else {
              older.add(notification);
            }
          }

          return RefreshIndicator(
            onRefresh: ref.read(notificationsProvider.notifier).refresh,
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                if (today.isNotEmpty)
                  NotificationGroup(
                    title: l10n.dateToday,
                    notifications: today,
                  ),
                if (yesterday.isNotEmpty)
                  NotificationGroup(
                    title: l10n.dateYesterday,
                    notifications: yesterday,
                  ),
                if (thisWeek.isNotEmpty)
                  NotificationGroup(
                    title: l10n.notificationsScreenGroupThisWeek,
                    notifications: thisWeek,
                  ),
                if (older.isNotEmpty)
                  NotificationGroup(
                    title: l10n.notificationsScreenGroupOlder,
                    notifications: older,
                  ),
              ],
            ),
          );
        },
        error: (e, st) => Center(child: StyledError(error: e, stackTrace: st)),
        loading: () => LoadingBody(l10n.notificationsScreenLoading),
      ),
    );
  }
}
