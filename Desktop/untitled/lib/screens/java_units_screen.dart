import 'package:flutter/material.dart';
import 'java_topics_screen.dart';
import 'important_questions_screen.dart';

class JavaUnitsScreen extends StatelessWidget {
  const JavaUnitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final units = [
      'Unit I',
      'Unit II',
      'Unit III',
      'Unit IV',
      'Unit V',
      'Unit VI',
      'Important Questions',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Java Programming'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: units.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Icon(
                index == 6 ? Icons.star : Icons.menu_book,
                color: index == 6 ? Colors.orange : Colors.blue,
              ),
              title: Text(
                units[index],
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                if (index == 6) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                      const ImportantQuestionsScreen(),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JavaTopicsScreen(
                        unit: index + 1,
                      ),
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