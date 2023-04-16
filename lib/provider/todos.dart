/* import 'package:flutter/material.dart';
import 'package:my_app/data/model/note.dart';
import 'package:my_app/api/firebase_api.dart';

class TodosProvider extends ChangeNotifier {
  List<Note> _notes = [];

  List<Note> get notes => _notes.where((note) => note.isdone == false).toList();

  List<Note> get noteCompleted =>
      _notes.where((note) => note.isdone == true).toList();

  void setNotes(List<Note> notes) {
    _notes = notes;
    notifyListeners();
  }

  void addNote(Note note) => FireBaseApi.addNote(note).then((id) {
        note.id = id;
        _notes.add(note);
        notifyListeners();
      });

  void removeNote(Note note) => FireBaseApi.deleteNote(note);

  bool toggleNote(Note note) {
    note.isdone = !note.isdone;
    FireBaseApi.updateNote(note);
    notifyListeners();
    return note.isdone;
  }

  void updateNote(
      Note note, String note_title, String note_content, int color_id) {
    note.note_title = note_title;
    note.note_content = note_content;
    note.last_update_date = DateTime.now();
    FireBaseApi.updateNote(note);
  }
} */
