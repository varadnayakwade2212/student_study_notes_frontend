import 'package:flutter/material.dart';
import '../models/my_note_model.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  String category = 'Java';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Note Title',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: descriptionController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Note Description',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              value: category,
              decoration: const InputDecoration(
                labelText: 'Category',
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
                  category = value!;
                });
              },
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  if (titleController.text.isEmpty ||
                      descriptionController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill all details'),
                      ),
                    );
                    return;
                  }

                  final note = MyNote(
                    title: titleController.text,
                    description: descriptionController.text,
                    category: category,
                    dateTime: DateTime.now(),
                  );

                  Navigator.pop(context, note);
                },
                icon: const Icon(Icons.save),
                label: const Text('Save Note'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}