import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_app/page/note_add_page.dart';

import '../data/model/note.dart';

class FireBaseApi {
  static CollectionReference ref =
      FirebaseFirestore.instance.collection('users');

  static Future<void> createAndupdate(Note note) async {
    if (note.id == null) {
      await ref
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('notes')
          .add(note.toJson());
    } else {
      await ref
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('notes')
          .doc(note.id)
          .update(note.toJson());
    }
  }
}
