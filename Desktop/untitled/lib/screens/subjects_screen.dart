import 'package:flutter/material.dart';

import 'java_units_screen.dart';
import 'c_topics_screen.dart';
import 'dbms_topics_screen.dart';
import 'network_topics_screen.dart';

class SubjectsScreen extends StatelessWidget {
  const SubjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subjects'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 8th - 10th
          Card(
            margin: const EdgeInsets.only(bottom: 15),
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.school),
              ),
              title: const Text(
                '8th – 10th',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: const Text(
                'Maharashtra State Board',
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                    const SchoolStandardsScreen(),
                  ),
                );
              },
            ),
          ),

          // 11th - 12th
          Card(
            margin: const EdgeInsets.only(bottom: 15),
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.menu_book),
              ),
              title: const Text(
                '11th – 12th',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: const Text(
                'Maharashtra State Board',
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                    const HigherSecondaryScreen(),
                  ),
                );
              },
            ),
          ),

          // Diploma
          Card(
            margin: const EdgeInsets.only(bottom: 15),
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.computer),
              ),
              title: const Text(
                'Diploma',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: const Text(
                'Diploma Syllabus',
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                    const DiplomaSubjectsScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================
// 8th - 10th STANDARD
// =====================================================

class SchoolStandardsScreen extends StatelessWidget {
  const SchoolStandardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final standards = [
      '8th Standard',
      '9th Standard',
      '10th Standard',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('8th – 10th'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: standards.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                child: Text('${index + 8}'),
              ),
              title: Text(
                standards[index],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: const Text(
                'Maharashtra State Board',
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SchoolSubjectsScreen(
                          standard: standards[index],
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

// =====================================================
// SCHOOL SUBJECTS
// =====================================================

class SchoolSubjectsScreen extends StatelessWidget {
  final String standard;

  const SchoolSubjectsScreen({
    super.key,
    required this.standard,
  });

  @override
  Widget build(BuildContext context) {
    final subjects = [
      'Marathi',
      'Hindi',
      'English',
      'Mathematics',
      'Science & Technology',
      'Social Sciences',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(standard),
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
              trailing: const Icon(
                Icons.arrow_forward_ios,
              ),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${subjects[index]} syllabus will be added later.',
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

// =====================================================
// 11th - 12th
// =====================================================

class HigherSecondaryScreen extends StatelessWidget {
  const HigherSecondaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final standards = [
      '11th Standard',
      '12th Standard',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('11th – 12th'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: standards.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                child: Text('${index + 11}'),
              ),
              title: Text(
                standards[index],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: const Text(
                'Maharashtra State Board',
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        HigherSecondarySubjectsScreen(
                          standard: standards[index],
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

// =====================================================
// 11th - 12th SUBJECTS
// =====================================================

class HigherSecondarySubjectsScreen extends StatelessWidget {
  final String standard;

  const HigherSecondarySubjectsScreen({
    super.key,
    required this.standard,
  });

  @override
  Widget build(BuildContext context) {
    final streams = [
      'Science',
      'Commerce',
      'Arts',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(standard),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: streams.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                child: Text('${index + 1}'),
              ),
              title: Text(
                streams[index],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
              ),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${streams[index]} subjects will be added later.',
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

// =====================================================
// DIPLOMA
// =====================================================

class DiplomaSubjectsScreen extends StatelessWidget {
  const DiplomaSubjectsScreen({super.key});

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
        title: const Text('Diploma Subjects'),
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
              trailing: const Icon(
                Icons.arrow_forward_ios,
              ),
              onTap: () {
                if (subjects[index] == 'Java Programming') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                      const JavaUnitsScreen(),
                    ),
                  );
                } else if (subjects[index] == 'C Programming') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                      const CTopicsScreen(),
                    ),
                  );
                } else if (subjects[index] == 'DBMS') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                      const DBMSTopicsScreen(),
                    ),
                  );
                } else if (subjects[index] ==
                    'Computer Networks') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                      const NetworkTopicsScreen(),
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