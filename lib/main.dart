import 'package:flutter/material.dart';
import 'package:flutter_notes_app_v1/screens/login_page.dart';
import 'package:flutter_notes_app_v1/screens/main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}
