import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../provider/theme_provider.dart';

Widget NoteCard(Function()? /* onLogPress,  */ onTap, QueryDocumentSnapshot doc,
    {Object? users, bool isdone = false}) {
  return InkWell(
    onTap: onTap,
    /* onLongPress: onLogPress, */
    child: Container(
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: MyThemes.cardsColor[doc['color_id']],
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            doc["note_title"],
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            doc["created"],
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            doc["note_content"],
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w300,
                overflow: TextOverflow.ellipsis),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    ),
  );
}
