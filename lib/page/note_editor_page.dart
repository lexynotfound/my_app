import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/provider/theme_provider.dart';

class NoteEditorScreen extends StatefulWidget {
  NoteEditorScreen(this.doc, {Key? key}) : super(key: key);
  QueryDocumentSnapshot doc;

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  int color_id = Random().nextInt(MyThemes.cardsColor.length);
  String date = DateTime.now().toString();
  TextEditingController note_TitleController = TextEditingController();
  TextEditingController note_ContentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    note_TitleController.text;
    note_ContentController.text;
  }

  @override
  Widget build(BuildContext context) {
    MyThemes.cardsColor[color_id];
    return Scaffold(
      appBar: AppBar(
        title: const Text(" "),
        actions: [
          IconButton(icon: const Icon(Icons.save), onPressed: update),
          IconButton(icon: const Icon(Icons.delete), onPressed: delete),
          IconButton(icon: const Icon(Icons.done_all), onPressed: done),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: note_TitleController =
                      TextEditingController(text: widget.doc["note_title"]),
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Title',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(date, style: const TextStyle(fontSize: 14)),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: note_ContentController =
                      TextEditingController(text: widget.doc["note_content"]),
                  keyboardType: TextInputType.multiline,
                  maxLines: 200,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Notes',
                  ),
                ),
                const SizedBox(
                  height: 29,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void update() async {
    // save to db
    CollectionReference ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('notes');
    await ref.doc(widget.doc.id).update({
      "note_title": note_TitleController.text,
      "note_content": note_ContentController.text,
      "created": date,
    });
    if (!mounted) return;
    Navigator.pop(context);
  }

  void delete() async {
    // save to db
    CollectionReference ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('notes');
    ref.doc(widget.doc.id).delete();
    Navigator.pop(context);
  }

  void done() async {
    // save to db
    CollectionReference ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('notes');
    await ref.doc(widget.doc.id).update({
      "note_title": note_TitleController.text,
      "note_content": note_ContentController.text,
      "created": date,
      "done": true,
    });
    if (!mounted) return;
    Navigator.pop(context);
  }
}
