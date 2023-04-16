import 'package:flutter/cupertino.dart';
import 'package:my_app/data/model/note.dart';

class Note {
  String note_title;
  String note_content;
  DateTime created;
  DateTime last_update_date;
  String id;
  bool isdone;

  Note({
    required this.note_title,
    this.note_content = "note_content",
    required this.created,
    required this.last_update_date,
    required this.id,
    this.isdone = false,
  });

  static Note fromJson(Map<String, dynamic> json) {
    return Note(
      note_title: json['note_title'],
      note_content: json['note_content'],
      created: DateTime.parse(json['created']),
      last_update_date: DateTime.parse(json['last_update_date']),
      id: json['id'],
      isdone: json['isdone'],
    );
  }

  Map<String, dynamic> toJson() => {
        'note_title': note_title,
        'note_content': note_content,
        'creation_date': created.toIso8601String(),
        'last_update_date': last_update_date.toIso8601String(),
        'id': id,
        'isdone': isdone,
      };

  static fromMap(Object? data) {}
}
