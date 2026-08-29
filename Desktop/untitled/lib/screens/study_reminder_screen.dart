import 'package:flutter/material.dart';
import '../services/notification_service.dart';

class StudyReminderScreen extends StatefulWidget {
  const StudyReminderScreen({super.key});

  @override
  State<StudyReminderScreen> createState() =>
      _StudyReminderScreenState();
}

class _StudyReminderScreenState
    extends State<StudyReminderScreen> {
  final titleController = TextEditingController();

  String selectedSubject = 'Java';

  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> selectTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (time != null) {
      setState(() {
        selectedTime = time;
      });
    }
  }

  Future<void> setReminder() async {
    if (titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter reminder title'),
        ),
      );
      return;
    }

    final now = DateTime.now();

    DateTime reminderTime = DateTime(
      now.year,
      now.month,
      now.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    // जर आजची वेळ निघून गेली असेल तर उद्याची reminder
    if (reminderTime.isBefore(now)) {
      reminderTime = reminderTime.add(
        const Duration(days: 1),
      );
    }

    await NotificationService.scheduleReminder(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: titleController.text.trim(),
      body: 'Time to study $selectedSubject 📚',
      dateTime: reminderTime,
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Reminder set for ${selectedTime.format(context)}',
        ),
      ),
    );

    titleController.clear();
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Study Reminder'),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              'Set Study Reminder ⏰',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            // Reminder Title
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Reminder Title',
                hintText: 'Example: Java Revision',
                prefixIcon: Icon(Icons.edit),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            // Subject
            DropdownButtonFormField<String>(
              value: selectedSubject,

              decoration: const InputDecoration(
                labelText: 'Subject',
                prefixIcon: Icon(Icons.book),
                border: OutlineInputBorder(),
              ),

              items: const [
                DropdownMenuItem(
                  value: 'Java',
                  child: Text('Java'),
                ),
                DropdownMenuItem(
                  value: 'C',
                  child: Text('C'),
                ),
                DropdownMenuItem(
                  value: 'DBMS',
                  child: Text('DBMS'),
                ),
                DropdownMenuItem(
                  value: 'Computer Networks',
                  child: Text('Computer Networks'),
                ),
              ],

              onChanged: (value) {
                setState(() {
                  selectedSubject = value!;
                });
              },
            ),

            const SizedBox(height: 25),

            // Time
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.access_time,
                  size: 32,
                ),

                title: const Text(
                  'Reminder Time',
                ),

                subtitle: Text(
                  selectedTime.format(context),
                ),

                trailing: ElevatedButton(
                  onPressed: selectTime,
                  child: const Text('Select'),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Set Reminder
            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton.icon(
                onPressed: setReminder,

                icon: const Icon(Icons.notifications_active),

                label: const Text(
                  'Set Reminder',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}