import 'dart:io';

import 'package:flutter/material.dart';

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
}

//notes Test Data
List<Note> notes = [
  Note.fromMap({
    'title': '오늘할일',
    'date': DateTime(2020, 11, 27, 21, 30),
    'content': '코딩열심히하기',
    'important': true,
    'image': null
  }),
  Note.fromMap({
    'title': '오늘할일',
    'date': DateTime(2020, 11, 27, 21, 30),
    'content': '코딩열심히하기',
    'important': false,
    'image': null
  }),
  Note.fromMap({
    'title': '오늘할일',
    'date': DateTime(2020, 11, 27, 21, 30),
    'content': '코딩열심히하기',
    'important': false,
    'image': null
  }),
  Note.fromMap({
    'title': '오늘할일',
    'date': DateTime(2020, 11, 27, 21, 30),
    'content': '코딩열심히하기',
    'important': false,
    'image': null
  }),
  Note.fromMap({
    'title': '오늘할일',
    'date': DateTime(2020, 11, 27, 21, 30),
    'content':
        '코딩열심히하기코딩열심히하\n기코딩열\n심히하기코딩열심히하기코딩열심히하기코딩열심히하기코딩열심히하기코딩열심히하기코딩열심히하기코딩열심히하기코딩열심히하기코딩열심히하기코딩열심히하기코딩열심히하기코딩열심히하기코딩열심히하기코딩열심히하기코딩열심히하기',
    'important': true,
    'image': null
  }),
];
