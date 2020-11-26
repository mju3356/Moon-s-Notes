import 'package:flutter/material.dart';

class Note {
  final String title;
  final DateTime date;
  final bool important;
  final String image;
  final String content;

  Note.fromMap(Map<String, dynamic> map)
      : title = map['title'],
        date = map['date'],
        important = map['important'],
        image = map['image'],
        content = map['content'];
}
