import 'package:flutter/material.dart';
import 'package:smart_home/core/utils/extensions.dart';

import '../../domain/notification_model.dart';
import 'notification_tile.dart';

class NotificationGroup extends StatelessWidget {
  const NotificationGroup({
    required this.title,
    required this.notifications,
    super.key,
  });

  final String title;
  final List<NotificationModel> notifications;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: context.colorScheme.outline,
            ),
          ),
        ),
        ...notifications.map(
          (notification) => NotificationTile(notification: notification),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
