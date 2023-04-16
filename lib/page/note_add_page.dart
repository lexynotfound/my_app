import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/provider/theme_provider.dart';

class NoteAddPage extends StatefulWidget {
  const NoteAddPage({Key? key}) : super(key: key);

  @override
  State<NoteAddPage> createState() => _NoteAddPageState();
}

class _NoteAddPageState extends State<NoteAddPage> {
  int color_id = Random().nextInt(MyThemes.cardsColor.length);
  String date = DateTime.now().toString();
  final TextEditingController note_TitleController = TextEditingController();
  final TextEditingController note_ContentController = TextEditingController();

  final ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('notes')
      .orderBy('created', descending: true)
      .snapshots();

  /* @override
  void initState() {
    title = TextEditingController(text: widget.doc["note_title"]);
    content = TextEditingController(text: widget.doc["note_content"]);
    super.initState();
  } */

  @override
  Widget build(BuildContext context) {
    MyThemes.cardsColor[color_id];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Note"),
        actions: [
          IconButton(icon: const Icon(Icons.save), onPressed: add),
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
                  controller: note_TitleController,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Title',
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(date, style: const TextStyle(fontSize: 14)),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: note_ContentController,
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

  void add() async {
    // save to db
    CollectionReference ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('notes');

    var data = {
      'note_title': note_TitleController.text,
      'note_content': note_ContentController.text,
      'id': ref.doc().id,
      'created': date,
      'color_id': color_id,
    };

    ref.add(data);

    //

    Navigator.pop(context);
  }
}
