import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotesPage(),
    );
  }
}

class NotesPage extends StatefulWidget {
  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {

  TextEditingController noteController =
      TextEditingController();

  List<String> notes = [];

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  // ADD NOTE
  void addNote() {
    if (noteController.text.isEmpty) return;

    setState(() {
      notes.add(noteController.text);
    });

    noteController.clear();

    saveNotes();
  }

  // DELETE NOTE
  void deleteNote(int index) {
    setState(() {
      notes.removeAt(index);
    });

    saveNotes();
  }

  // EDIT NOTE
  void editNote(int index) {

    noteController.text = notes[index];

    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Note"),

          content: TextField(
            controller: noteController,
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text("Cancel"),
            ),

            TextButton(
              onPressed: () {

                setState(() {
                  notes[index] =
                      noteController.text;
                });

                saveNotes();

                noteController.clear();

                Navigator.pop(context);
              },

              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  // SAVE NOTES
  Future<void> saveNotes() async {

    final prefs =
        await SharedPreferences.getInstance();

    String data = jsonEncode(notes);

    await prefs.setString("notes", data);
  }

  // LOAD NOTES
  Future<void> loadNotes() async {

    final prefs =
        await SharedPreferences.getInstance();

    String? data =
        prefs.getString("notes");

    if (data != null) {

      setState(() {

        notes =
            List<String>.from(
              jsonDecode(data),
            );

      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Notes App"),
      ),

      floatingActionButton:
          FloatingActionButton(

        onPressed: () {

          noteController.clear();

          showDialog(
            context: context,

            builder: (context) {

              return AlertDialog(

                title: const Text("Add Note"),

                content: TextField(
                  controller: noteController,

                  decoration:
                      const InputDecoration(
                    hintText: "Enter note",
                  ),
                ),

                actions: [

                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },

                    child: const Text("Cancel"),
                  ),

                  TextButton(
                    onPressed: () {

                      addNote();

                      Navigator.pop(context);
                    },

                    child: const Text("Add"),
                  ),
                ],
              );
            },
          );
        },

        child: const Icon(Icons.add),
      ),

      body: notes.isEmpty

          ? const Center(
              child: Text("No Notes Yet"),
            )

          : ListView.builder(

              itemCount: notes.length,

              itemBuilder: (context, index) {

                return Card(

                  margin: const EdgeInsets.all(10),

                  child: ListTile(

                    title: Text(notes[index]),

                    trailing: Row(
                      mainAxisSize:
                          MainAxisSize.min,

                      children: [

                        IconButton(

                          icon:
                              const Icon(Icons.edit),

                          onPressed: () {
                            editNote(index);
                          },
                        ),

                        IconButton(

                          icon:
                              const Icon(Icons.delete),

                          onPressed: () {
                            deleteNote(index);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
