import 'package:flutter/material.dart';
import 'package:univarsity_management_system/models/notification_model.dart';

class NotificationScreen extends StatelessWidget {
  final List<NotificationModel> notifications = [
    NotificationModel(
      title: 'New Event Added',
      description: 'AUST Job Fair has been added to the events.',
      type: 'event', // New event type
      timestamp: DateTime.now().subtract(Duration(days: 1)), // 1 day ago
    ),
    NotificationModel(
      title: 'Event Reminder',
      description: 'DIU UTA Program starts in 2 days.',
      type: 'reminder', // Reminder type
      timestamp: DateTime.now().subtract(Duration(hours: 5)), // 5 hours ago
    ),
    NotificationModel(
      title: 'Someone Interested',
      description: 'A user showed interest in your event.',
      type: 'interest', // Someone interested type
      timestamp: DateTime.now().subtract(
        Duration(minutes: 10),
      ), // 10 minutes ago
    ),
  ];

  NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Notification',
          style: TextStyle(
            color: const Color.fromARGB(255, 63, 43, 1),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('images/main_logo.png', height: 32),
        ),
        flexibleSpace: ClipRRect(
          borderRadius: BorderRadius.circular(30), // Rounds all four corners
          child: Container(color: const Color(0xFFD1A170)),
        ),
      ),

      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Card(
            margin: const EdgeInsets.all(8),
            elevation: 4,
            child: ListTile(
              leading: _getLogo(
                notification.type,
              ), // Get logo based on notification type
              title: _buildTitleAndDescription(notification),
              subtitle: _getTrailing(notification.timestamp),
              onLongPress: () {
                _showDeleteOptions(context);
              },
            ),
          );
        },
      ),
    );
  }

  // Helper method to get the default Flutter logo based on notification type
  Widget _getLogo(String type) {
    IconData icon;
    // Choose the correct icon based on the event type
    switch (type) {
      case 'event':
        icon = Icons.event; // Event icon
        break;
      case 'reminder':
        icon = Icons.alarm; // Reminder (alarm) icon
        break;
      case 'interest':
        icon = Icons.favorite; // Interest (favorite) icon
        break;
      default:
        icon = Icons.notifications; // Default notifications icon
    }

    return Icon(
      icon,
      size: 40,
      color: Color(0xFF4A2A11), // Set the color for the icons
    );
  }

  // Helper method to build the title and description
  Widget _buildTitleAndDescription(NotificationModel notification) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          notification.title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(height: 4),
        Text(
          notification.description,
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
      ],
    );
  }

  // Helper method to format the timestamp into relative time
  Widget _getTrailing(DateTime timestamp) {
    final timeAgo = timeago.format(timestamp);
    return Align(
      alignment: Alignment.centerRight,
      child: Text(timeAgo, style: TextStyle(fontSize: 12, color: Colors.grey)),
    );
  }

  // Show options for deleting or turning off notifications
  void _showDeleteOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Notification'),
          content: const Text(
            'Do you want to delete this notification or turn it off?',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                // Add logic to delete the notification
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Turn Off'),
              onPressed: () {
                // Add logic to turn off the notification
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
