import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../domain/notification_model.dart';

class NotificationsRepository {
  final _supabase = Supabase.instance.client;

  Future<List<NotificationModel>> fetchNotifications() async {
    final userId = _supabase.auth.currentUser?.id;
    debugPrint('LOG: user id: $userId');
    if (userId == null) return [];
    final response = await _supabase
        .from('notifications')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);
    debugPrint('LOG: Notifications Response $response');
    return response.map((e) => NotificationModel.fromJson(e)).toList();
  }

  Future<void> markAsRead(int notificationId) async {
    await _supabase
        .from('notifications')
        .update({'is_read': true})
        .eq('id', notificationId);
  }

  Future<void> delete(int notificationId) async {
    await _supabase.from('notifications').delete().eq('id', notificationId);
  }

  Future<void> deleteAll() async {
    await _supabase
        .from('notifications')
        .delete()
        .eq('user_id', _supabase.auth.currentUser!.id);
  }
}
