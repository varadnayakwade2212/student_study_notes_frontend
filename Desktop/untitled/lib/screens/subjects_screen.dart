import 'package:flutter/material.dart';
import 'java_units_screen.dart';
import 'c_topics_screen.dart';
import 'dbms_topics_screen.dart';
import 'network_topics_screen.dart';

class SubjectsScreen extends StatelessWidget {
  const SubjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final subjects = [
      'Java Programming',
      'C Programming',
      'DBMS',
      'Computer Networks',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Subjects'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: subjects.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                child: Text('${index + 1}'),
              ),
              title: Text(
                subjects[index],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),

              onTap: () {
                if (subjects[index] == 'Java Programming') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const JavaUnitsScreen(),
                    ),
                  );
                }

                if (subjects[index] == 'C Programming') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CTopicsScreen(),
                    ),
                  );
                }

                if (subjects[index] == 'DBMS') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DBMSTopicsScreen(),
                    ),
                  );
                }

                if (subjects[index] == 'Computer Networks') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NetworkTopicsScreen(),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}