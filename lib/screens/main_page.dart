import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_notes_app_v1/model/notes.dart';
import 'package:flutter_notes_app_v1/screens/detail_page.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController _controller = TextEditingController();
  final DateFormat _dateFormat = DateFormat('dd MMM');
  bool _delete = false;
  List<Widget> results = [];
  List<Note> notes = [];

  void initState() {
    super.initState();
  }

  callbackNote(num, Note note) {
    setState(() {
      notes[num].important = note.important;
      notes[num].content = note.content;
      notes[num].title = note.title;
      notes[num].image = note.image;
      saveNote(notes);
    });
  }

  Note _createNote() {
    notes.add(Note.fromMap({
      'title': '제목',
      'date': DateTime.now().toString(),
      'content': '내용',
      'important': false,
      'image': null
    }));

    return notes.last;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return FutureBuilder<Object>(
        future: loadNote(),
        builder: (context, snapshot) {
          if(snapshot.hasData==false){
            return CircularProgressIndicator();
          }
         else {
            return GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  setState(() {
                    if (_delete) {
                      uncheckBox();
                    }

                    _delete = false;
                  });
                },
                child: SafeArea(
                  child: Scaffold(
                    floatingActionButton: FloatingActionButton(
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                        note: _createNote(),
                                        num: notes.length - 1,
                                        callbackNote: callbackNote,
                                      )));
                          saveNote(notes);
                        });
                      },
                    ),
                    body: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: width * 0.03,
                              ),
                              Container(
                                height: height * 0.07,
                                width: height * 0.07,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage('images/logo.png')),
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Text(
                                  "Moon's Note",
                                  style: TextStyle(
                                      fontSize: width * 0.07,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: height * 0.04),
                                child: Text(
                                  'Developed by Moon',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: width * 0.03),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Container(
                            width: width * 0.9,
                            height: height * 0.14,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black45,
                                      offset: Offset(5, 5),
                                      blurRadius: 20)
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  _showResults(_controller.text, height, width,
                                              _dateFormat)
                                          .length
                                          .toString() +
                                      ' Notes',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: width * 0.05),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 40,
                                  child: TextField(
                                    controller: _controller,
                                    onChanged: (text) {
                                      setState(() {
                                        results = _showResults(
                                            text, height, width, _dateFormat);
                                      });
                                    },
                                    decoration: InputDecoration(
                                      suffixIcon: Icon(Icons.search),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                      ),
                                      contentPadding:
                                          EdgeInsets.fromLTRB(15, 0, 0, 20),
                                      fillColor: Colors.white,
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'Notes',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: width * 0.05),
                                      ),
                                      Container(
                                        width: 60,
                                        height: 5,
                                        color: Colors.blue,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: width * 0.53,
                                  ),
                                  _delete
                                      ? SizedBox(
                                          height: height * 0.04,
                                          child: RaisedButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            color: Colors.red,
                                            onPressed: () {
                                              List _delDatas = [];
                                              for (int i = 0;
                                                  i < notes.length;
                                                  i++) {
                                                if (notes[i].delete) {
                                                  _delDatas.add(i);
                                                }
                                              }
                                              _delDatas =
                                                  _delDatas.reversed.toList();
                                              showDialog(
                                                context: context,
                                                barrierDismissible: false,
                                                builder: (_) =>
                                                    CupertinoAlertDialog(
                                                  title: Text('삭제'),
                                                  content: Text(_delDatas.length
                                                          .toString() +
                                                      '개의 노트를 삭제하시겠습니까?'),
                                                  actions: [
                                                    CupertinoDialogAction(
                                                      child: Text('No'),
                                                      onPressed: () {
                                                        setState(() {
                                                          _delete = false;
                                                          Navigator.of(context)
                                                              .pop();
                                                        });
                                                      },
                                                    ),
                                                    CupertinoDialogAction(
                                                      child: Text('YES'),
                                                      onPressed: () {
                                                        for (int i
                                                            in _delDatas) {
                                                          print(i);

                                                          notes.removeAt(i);
                                                        }
                                                        saveNote(notes);
                                                        setState(() {
                                                          _delete = false;
                                                          Navigator.of(context)
                                                              .pop();
                                                        });
                                                      },
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                            child: Text(
                                              'DEL',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ))
                                      : Container()
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.009,
                          ),
                          Expanded(
                            child: _showResults(_controller.text, height, width,
                                        _dateFormat)
                                    .isNotEmpty
                                ? ListView(
                                    children: _showResults(_controller.text,
                                        height, width, _dateFormat),
                                  )
                                : ListView(children: [NoNotes(height, width)]),
                          )
                        ],
                      ),
                    ),
                  ),
                ));
          }
        });
  }

  List<Widget> _showResults(
      String search, double height, double width, DateFormat _dateFormatter) {
    List<Widget> results = [];
    search = search.toUpperCase();

    for (var j = 0; j < 2; j++) {
      for (int i = 0; i < notes.length; i++) {
        if ((j == 0 && notes[i].important) || (j == 1 && !notes[i].important)) {
          if (notes[i].title.toLowerCase().toUpperCase().contains(search) ||
              notes[i].content.toUpperCase().contains(search) ||
              notes[i].date.toString().toUpperCase().contains(search)) {
            results.add(Padding(
              padding: EdgeInsets.all(10),
              child: GestureDetector(
                onLongPress: () {
                  setState(() {
                    _delete = !_delete;
                    if (_delete) {
                      uncheckBox();
                    }
                  });
                },
                onTap: () {
                  if (_delete) {
                    setState(() {
                      notes[i].delete = !notes[i].delete;
                    });
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailPage(
                                  note: notes[i],
                                  num: i,
                                  callbackNote: callbackNote,
                                )));
                  }
                },
                child: Container(
                  height: height * 0.2,
                  width: width * 0.9,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(235, 235, 235, 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                _delete
                                    ? SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: Checkbox(
                                            value: notes[i].delete,
                                            onChanged: (value) {
                                              setState(() {
                                                notes[i].delete = value;
                                              });
                                            }),
                                      )
                                    : Container(),
                                notes[i].important
                                    ? Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      )
                                    : Container(),
                                Text(
                                  notes[i].title,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: height * 0.025),
                                ),
                              ],
                            ),
                            Text(
                              _dateFormatter.format(
                                notes[i].date,
                              ),
                              style: TextStyle(
                                color: Color(0xFFAFB4C6),
                                fontSize: height * 0.02,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: height * 0.008,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: height * 0.11,
                              width: width * 0.65,
                              child: Text(
                                notes[i].content,
                                maxLines: 4,
                                style: TextStyle(fontSize: height * 0.022),
                              ),
                            ),
                            notes[i].image == null
                                ? Container()
                                : SizedBox(
                                    height: height * 0.1,
                                    width: height * 0.1,
                                    child: Image.file(notes[i].image),
                                  )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
          }
        }
      }
    }

    return results;
  }

  Widget NoNotes(height, width) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('images/empty.png'),
        SizedBox(height: height * 0.05),
        Text(
          'Note is Empty....',
          style: TextStyle(fontSize: width * 0.08, color: Colors.blueGrey),
        ),
        SizedBox(
          height: height * 0.1,
        )
      ],
    );
  }

  Future loadNote() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List jsonNotes = prefs.getStringList('notes');
    if (jsonNotes.isEmpty) {
      return notes = [];
    }
    print(jsonNotes);
    return notes = jsonNotes.map((e) => Note.fromMap(json.decode(e))).toList();
  }

  static saveNote(List<Note> notes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List jsonNotes = notes.map((e) => json.encode(Note.toMap(e))).toList();
    prefs.setStringList('notes', jsonNotes);
  }

  uncheckBox() {
    for (int i = 0; i < notes.length; i++) {
      notes[i].delete = false;
    }
  }
}
