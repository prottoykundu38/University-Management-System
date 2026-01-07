import 'package:flutter/material.dart';
import 'package:univarsity_management_system/Screens/event_screen.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Map<String, String>> favoriteEvents;

  const FavoriteScreen({super.key, required this.favoriteEvents});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Event',
          style: TextStyle(
            color: const Color.fromARGB(255, 63, 43, 1),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/main_logo.png', height: 32),
        ),
        flexibleSpace: ClipRRect(
          borderRadius: BorderRadius.circular(30), // Rounds all four corners
          child: Container(color: const Color(0xFFD1A170)),
        ),
      ),

      body:
          favoriteEvents.isEmpty
              ? const Center(
                child: Text(
                  "No events yet.",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              )
              : ListView.builder(
                itemCount: favoriteEvents.length,
                itemBuilder: (context, index) {
                  final event = favoriteEvents[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => EventDetailPage(
                                title: event['title']!,
                                image: event['image']!,
                                description: event['description']!,
                                date: event['date']!,
                                time: event['time']!,
                                category: event['category']!,
                                fullDescription: event['full_description']!,
                              ),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.all(8),
                      elevation: 4,
                      child: ListTile(
                        leading:
                            event['image'] != null && event['image']!.isNotEmpty
                                ? Image.asset(
                                  event['image']!,
                                  width: 70,
                                  fit: BoxFit.cover,
                                )
                                : const Icon(
                                  Icons.event,
                                  size: 48,
                                  color: Colors.deepPurple,
                                ),
                        title: Text(event['title']!),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(event['description']!),
                            Text('Date: ${event['date']}'),
                            Text('Time: ${event['time']}'),
                            Text('Category: ${event['category']}'),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
