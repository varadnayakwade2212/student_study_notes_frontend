import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/my_note_model.dart';
import 'add_note_screen.dart';

class MyNotesScreen extends StatefulWidget {
  const MyNotesScreen({super.key});

  @override
  State<MyNotesScreen> createState() => _MyNotesScreenState();
}

class _MyNotesScreenState extends State<MyNotesScreen> {
  List<MyNote> notes = [];

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  // Load saved notes
  Future<void> loadNotes() async {
    final prefs = await SharedPreferences.getInstance();

    final savedNotes = prefs.getStringList('my_notes');

    if (savedNotes != null) {
      final loadedNotes = savedNotes.map((note) {
        return MyNote.fromMap(
          jsonDecode(note),
        );
      }).toList();

      setState(() {
        notes = loadedNotes;
      });
    }
  }

  // Save notes permanently
  Future<void> saveNotes() async {
    final prefs = await SharedPreferences.getInstance();

    final savedNotes = notes.map((note) {
      return jsonEncode(note.toMap());
    }).toList();

    await prefs.setStringList('my_notes', savedNotes);
  }

  // Add new note
  Future<void> addNote(MyNote note) async {
    setState(() {
      notes.add(note);
    });

    await saveNotes();
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    final todayNotes = notes.where((note) {
      return note.dateTime.year == today.year &&
          note.dateTime.month == today.month &&
          note.dateTime.day == today.day;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Notes"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Today's Notes",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Expanded(
              child: todayNotes.isEmpty
                  ? const Center(
                child: Text(
                  "No notes added today.",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              )
                  : ListView.builder(
                itemCount: todayNotes.length,
                itemBuilder: (context, index) {
                  final note = todayNotes[index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: const Icon(
                        Icons.note_alt,
                        color: Colors.blue,
                        size: 32,
                      ),

                      title: Text(
                        note.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),

                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          'Category: ${note.category}\n'
                              '${note.description}\n\n'
                              'Date: ${note.dateTime.day}/'
                              '${note.dateTime.month}/'
                              '${note.dateTime.year}\n'
                              'Time: ${note.dateTime.hour}:'
                              '${note.dateTime.minute.toString().padLeft(2, '0')}',
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final note = await Navigator.push<MyNote>(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNoteScreen(),
            ),
          );

          if (note != null) {
            await addNote(note);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}