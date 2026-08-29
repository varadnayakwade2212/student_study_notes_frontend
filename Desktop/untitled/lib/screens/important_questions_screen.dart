import 'package:flutter/material.dart';

class ImportantQuestionsScreen extends StatelessWidget {
  const ImportantQuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final questions = [
      'Explain features of Java.',
      'Explain Class and Object.',
      'Explain inheritance and its types.',
      'Explain method overriding.',
      'Explain interfaces.',
      'Explain exception handling.',
      'Explain thread life cycle.',
      'Explain AWT and Swing.',
      'Explain event handling.',
      'Explain socket programming.',
      'Explain JDBC architecture.',
      'Explain JDBC drivers.',
      'Explain Statement and PreparedStatement.',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Important Questions'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: const Icon(
                Icons.star,
                color: Colors.orange,
              ),
              title: Text(
                questions[index],
                style: const TextStyle(fontSize: 16),
              ),
            ),
          );
        },
      ),
    );
  }
}