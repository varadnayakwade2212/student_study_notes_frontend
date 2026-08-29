import 'package:flutter/material.dart';
import 'subjects_screen.dart';
import 'my_notes_screen.dart';
import 'study_reminder_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  final Function(bool)? onThemeChanged;

  const HomeScreen({
    super.key,
    this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Study Notes'),
        centerTitle: true,

        // Profile button
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            tooltip: 'Profile',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                    onThemeChanged: onThemeChanged,
                  ),
                ),
              );
            },
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Welcome
            const Text(
              'Welcome Student 👋',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Study smart, learn better!',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            // My Notes
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.menu_book,
                  size: 35,
                  color: Colors.blue,
                ),

                title: const Text(
                  'My Notes',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                subtitle: const Text(
                  'View your study notes',
                ),

                trailing: const Icon(
                  Icons.arrow_forward_ios,
                ),

                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                      const MyNotesScreen(),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 15),

            // Subjects
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.book,
                  size: 35,
                  color: Colors.green,
                ),

                title: const Text(
                  'Subjects',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                subtitle: const Text(
                  'Select your subject',
                ),

                trailing: const Icon(
                  Icons.arrow_forward_ios,
                ),

                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                      const SubjectsScreen(),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 15),

            // Study Reminder
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.alarm,
                  size: 35,
                  color: Colors.orange,
                ),

                title: const Text(
                  'Study Reminder',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                subtitle: const Text(
                  'Set a reminder for your study',
                ),

                trailing: const Icon(
                  Icons.arrow_forward_ios,
                ),

                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                      const StudyReminderScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}