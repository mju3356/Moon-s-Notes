// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';
import 'dart:io';
import 'dart:core';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_notes_app_v1/main.dart';

void main() {


  List notes=[Note.fromMap({
    "title":'a',
    "date":'a',
    "important":false,
    "image":null,
    "content":'a',


  })];

  print(notes);
}

class Note {
  String title;
  final DateTime date;
  bool important;
  File image;
  String content;
  bool delete;

  Note.fromMap(Map<String, dynamic> map)
      : title = map['title'],
        date = map['date'],
        important = map['important'],
        image = map['image'],
        content = map['content'],
        delete = false;

  static Map<String, dynamic> toMap(Note notes) =>
      {
        'title': notes.title,
        'date': notes.date,
        'important': notes.important,
        'image': notes.image,
        'content': notes.content,
        'delete': false
      };

  static String encode(List<Note>notes) =>
      json.encode(
          notes.map<Map<String, dynamic>>((e) => Note.toMap(e)).toList());
  
  static List<Note> decode(String notes)=>
      (json.decode(notes) as List<dynamic> ).map((e) => Note.fromMap(e)).toList();



}