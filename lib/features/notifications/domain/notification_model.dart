class NotificationModel {
  final int id;
  final String title;
  final String? body;
  final DateTime timestamp;
  final bool isRead;
  final int? componentId;

  NotificationModel({
    required this.id,
    required this.title,
    this.body,
    required this.timestamp,
    required this.isRead,
    this.componentId,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json['id'] as int,
        title: json['title'] as String,
        body: json['message'] as String?,
        timestamp: DateTime.parse(json['created_at'] as String).toLocal(),
        isRead: json['is_read'] as bool,
        componentId: json['component_id'],
      );

  NotificationModel copyWith({required bool isRead}) {
    return NotificationModel(
      id: id,
      title: title,
      body: body,
      timestamp: timestamp,
      isRead: isRead,
      componentId: componentId,
    );
  }

  @override
  String toString() {
    return 'AppNotification{id: $id, title: $title, message: $body, isRead: $isRead, componentId: $componentId}';
  }
}
