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

  final TextEditingController searchController =
  TextEditingController();

  String selectedCategory = 'All';

  final List<String> categories = [
    'All',
    'Java',
    'C',
    'DBMS',
    'Computer Networks',
  ];

  @override
  void initState() {
    super.initState();
    loadNotes();

    searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // ================= LOAD NOTES =================

  Future<void> loadNotes() async {
    final prefs = await SharedPreferences.getInstance();

    final savedNotes = prefs.getStringList('my_notes');

    if (savedNotes != null) {
      final loadedNotes = savedNotes.map((note) {
        return MyNote.fromMap(jsonDecode(note));
      }).toList();

      setState(() {
        notes = loadedNotes;
      });
    }
  }

  // ================= SAVE NOTES =================

  Future<void> saveNotes() async {
    final prefs = await SharedPreferences.getInstance();

    final savedNotes = notes.map((note) {
      return jsonEncode(note.toMap());
    }).toList();

    await prefs.setStringList('my_notes', savedNotes);
  }

  // ================= ADD NOTE =================

  Future<void> addNote(MyNote note) async {
    setState(() {
      notes.add(note);
    });

    await saveNotes();
  }

  // ================= EDIT NOTE =================

  Future<void> editNote(MyNote note) async {
    final titleController =
    TextEditingController(text: note.title);

    final descriptionController =
    TextEditingController(text: note.description);

    String editCategory = note.category;

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Edit Note'),

              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    // Title
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'Note Title',
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Description
                    TextField(
                      controller: descriptionController,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        labelText: 'Note Description',
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Category
                    DropdownButtonFormField<String>(
                      value: editCategory,
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
                        setDialogState(() {
                          editCategory = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),

              actions: [

                // Cancel
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),

                // Save
                ElevatedButton(
                  onPressed: () async {
                    if (titleController.text.trim().isEmpty ||
                        descriptionController.text.trim().isEmpty) {
                      return;
                    }

                    final index = notes.indexOf(note);

                    if (index != -1) {
                      setState(() {
                        notes[index] = MyNote(
                          title: titleController.text.trim(),
                          description:
                          descriptionController.text.trim(),
                          category: editCategory,
                          dateTime: note.dateTime,
                        );
                      });

                      await saveNotes();
                    }

                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // ================= DELETE NOTE =================

  Future<void> deleteNote(MyNote note) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Note'),

          content: const Text(
            'Are you sure you want to delete this note?',
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancel'),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text(
                'Delete',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (shouldDelete == true) {
      setState(() {
        notes.remove(note);
      });

      await saveNotes();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Note deleted successfully'),
          ),
        );
      }
    }
  }

  // ================= BUILD =================

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    final todayNotes = notes.where((note) {
      return note.dateTime.year == today.year &&
          note.dateTime.month == today.month &&
          note.dateTime.day == today.day;
    }).toList();

    // Search + Category Filter
    final filteredNotes = todayNotes.where((note) {
      final searchText =
      searchController.text.toLowerCase();

      final matchesSearch =
          note.title.toLowerCase().contains(searchText) ||
              note.description.toLowerCase().contains(searchText);

      final matchesCategory =
          selectedCategory == 'All' ||
              note.category == selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Heading
            const Text(
              "Today's Notes",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            // Search
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search notes...',
                prefixIcon: const Icon(Icons.search),

                suffixIcon:
                searchController.text.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    searchController.clear();
                  },
                )
                    : null,

                border: const OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            // Categories
            SizedBox(
              height: 45,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,

                itemBuilder: (context, index) {
                  final category = categories[index];

                  return Padding(
                    padding:
                    const EdgeInsets.only(right: 8),

                    child: ChoiceChip(
                      label: Text(category),

                      selected:
                      selectedCategory == category,

                      onSelected: (selected) {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 15),

            // Notes List
            Expanded(
              child: filteredNotes.isEmpty
                  ? const Center(
                child: Text(
                  'No notes found.',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              )
                  : ListView.builder(
                itemCount: filteredNotes.length,

                itemBuilder: (context, index) {
                  final note = filteredNotes[index];

                  return Card(
                    margin:
                    const EdgeInsets.only(
                      bottom: 12,
                    ),

                    child: ListTile(
                      leading: const Icon(
                        Icons.note_alt,
                        color: Colors.blue,
                        size: 32,
                      ),

                      title: Text(
                        note.title,
                        style: const TextStyle(
                          fontWeight:
                          FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),

                      subtitle: Padding(
                        padding:
                        const EdgeInsets.only(
                          top: 8,
                        ),

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

                      // Edit + Delete
                      trailing: PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'edit') {
                            editNote(note);
                          }

                          if (value == 'delete') {
                            deleteNote(note);
                          }
                        },

                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'edit',
                            child: Row(
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                SizedBox(width: 10),
                                Text('Edit'),
                              ],
                            ),
                          ),

                          const PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                SizedBox(width: 10),
                                Text('Delete'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // Add Note
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final note = await Navigator.push<MyNote>(
            context,
            MaterialPageRoute(
              builder: (context) =>
              const AddNoteScreen(),
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