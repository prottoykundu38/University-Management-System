class NotificationModel {
  final String title;
  final String description;
  final String type;  // Add this field for notification type (event, reminder, interest)
  final DateTime timestamp;  // Change this to DateTime

  NotificationModel({
    required this.title,
    required this.description,
    required this.type,
    required this.timestamp,
  });
}
