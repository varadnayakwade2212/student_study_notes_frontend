import 'package:flutter/material.dart';
import 'notes_screen.dart';

class CTopicsScreen extends StatelessWidget {
  const CTopicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final topics = [
      'C Introduction',
      'Variables and Data Types',
      'Operators',
      'Decision Making',
      'Loops',
      'Arrays',
      'Strings',
      'Functions',
      'Pointers',
      'Structures',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('C Programming'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: topics.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: CircleAvatar(
                child: Text('${index + 1}'),
              ),
              title: Text(topics[index]),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NoteScreen(
                      topic: topics[index],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}