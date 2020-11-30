import 'dart:io';

import 'package:flutter/material.dart';

class Note {
  final String title;
  final DateTime date;
  bool important;
  final File image;
  final String content;
  bool delete;

  Note.fromMap(Map<String, dynamic> map)
      : title = map['title'],
        date = map['date'],
        important = map['important'],
        image = map['image'],
        content = map['content'],
        delete = false;
}
