import 'package:flutter/material.dart';
import 'notes_screen.dart';

class DBMSTopicsScreen extends StatelessWidget {
  const DBMSTopicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final topics = [
      'Introduction to DBMS',
      'DBMS Architecture',
      'Data Models',
      'Keys',
      'DDL and DML',
      'SQL',
      'Joins',
      'Views',
      'Triggers',
      'PostgreSQL',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('DBMS'),
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