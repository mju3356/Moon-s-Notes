import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Note {
  String title;
  final DateTime date;
  bool important;
  File image;
  String content;
  bool delete;


  Note.fromMap(Map<String, dynamic> map)
      : title = map['title'],
        date = DateTime.parse(map['date']),
        important = map['important'],
        image = map['image']==null?null:File(map['image']),
        content = map['content'],
        delete = false;

  static Map<String,dynamic> toMap(Note note)=>{
    'title':note.title,
    'date':note.date.toString(),
    'important':note.important,
    'image':note.image==null?null:note.image.path,
    'content':note.content,
    'delete':false
  };




}



