import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_home/core/constants/images.dart';
import 'package:smart_home/core/l10n/app_localizations.dart';
import 'package:smart_home/core/providers/language_provider.dart';
import 'package:smart_home/core/utils/extensions.dart';
import 'package:smart_home/core/utils/text_formatter.dart';
import 'package:smart_home/features/notifications/application/notifications_provider.dart';

import '../../application/notification_component_provider.dart';
import '../../domain/notification_model.dart';

class NotificationTile extends ConsumerWidget {
  const NotificationTile({required this.notification, super.key});

  final NotificationModel notification;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final component = ref.watch(
      notificationComponentProvider(notification.componentId),
    );
    final locale = ref.watch(selectedLanguageProvider);

    final svgAsset = component?.image ?? Images.BELL;
    return InkWell(
      onTap: () {
        ref.read(notificationsProvider.notifier).markAsRead(notification.id);
        if (component != null) context.push('/components/${component.id}');
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SvgPicture.asset(svgAsset, height: 45),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                spacing: 2,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  if (notification.body != null) Text(notification.body!),
                  Text(
                    TextFormatter.formatDate(
                      notification.timestamp,
                      locale,
                      l10n,
                    ),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.outline,
                    ),
                  ),
                ],
              ),
            ),
            if (!notification.isRead)
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
