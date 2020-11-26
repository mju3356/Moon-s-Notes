import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notes_app_v1/model/notes.dart';
import 'package:intl/intl.dart';


class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //임의 데이터
  List<Note> notes = [

    Note.fromMap({
      'title': '오늘할일',
      'date': DateTime(2020, 11, 27,21,30),
      'content': '코딩열심히하기',
      'important': true,
      'image': 'No'
    }),
        Note.fromMap({
      'title': '오늘할일',
      'date': DateTime(2020, 11, 27,21,30),
      'content': '코딩열심히하기',
      'important': false,
      'image': 'No'
    }),
        Note.fromMap({
      'title': '오늘할일',
      'date': DateTime(2020, 11, 27,21,30),
      'content': '코딩열심히하기',
      'important': false,
      'image': 'No'
    }),
        Note.fromMap({
      'title': '오늘할일',
      'date': DateTime(2020, 11, 27,21,30),
      'content': '코딩열심히하기',
      'important': false,
      'image': 'No'
    }),
        Note.fromMap({
      'title': '오늘할일',
      'date': DateTime(2020, 11, 27,21,30),
      'content': '코딩열심히하기코딩열심히하\n기코딩열\n심히하기코딩열심히하기코딩열심히하기코딩열심히하기코딩열심히하기코딩열심히하기코딩열심히하기코딩열심히하기코딩열심히하기코딩열심히하기코딩열심히하기코딩열심히하기코딩열심히하기코딩열심히하기코딩열심히하기코딩열심히하기',
      'important': true,
      'image': 'No'
    }),
        Note.fromMap({
      'title': '오늘할일',
      'date': DateTime(2020, 11, 27,21,30),
      'content': '코딩열심히하기',
      'important': true,
      'image': 'No'
    }),
        Note.fromMap({
      'title': '오늘할일',
      'date': DateTime(2020, 11, 27,21,30),
      'content': '코딩열심히하기',
      'important': true,
      'image': 'No'
    }),


  ];
  TextEditingController _controller = TextEditingController();
  final DateFormat _dateFormat =DateFormat('dd MMM');



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return SafeArea(
        child: Scaffold(
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
                      image:
                          DecorationImage(image: AssetImage('images/man.jpg')),
                      borderRadius: BorderRadius.circular(20)),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Moon',
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                )
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
                boxShadow:[BoxShadow(
                  color: Colors.black45 ,
                  offset: Offset(5,5),
                  blurRadius: 20
                )]
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    notes.length.toString() + ' Notes',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.transparent),

                        ),
                        contentPadding: EdgeInsets.fromLTRB(15, 0, 0, 20),
                        fillColor: Colors.white,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),

                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height*0.02,),
            Row(
              children: [
                SizedBox(width: 10,),
                Column(
                  children: [
                    Text('Notes',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20
                    ),),
                    Container(
                      width: 60,
                      height: 5,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: height*0.009,),

            Expanded(
              child: ListView(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                children: _createNotes(notes, height, width,_dateFormat),
              ),
            )
          ],
        ),
      ),
    ));
  }

  List<Widget> _createNotes(List<Note> notes, double height, double width,DateFormat _dateFormatter) {
    List<Widget> results = [];
    for (int i = 0; i < notes.length; i++) {
      results.add(Padding(
        padding: EdgeInsets.all(10),
        child: InkWell(
          onTap: (){
          },
          child: Container(
            height: height * 0.2,
            width: width * 0.9,
            decoration: BoxDecoration(
                color: Color.fromRGBO(235, 235, 235,1),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          notes[i].important?Icon(Icons.star,color: Colors.amber,):Container(),
                          Text(
                            notes[i].title,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Text(
                        _dateFormatter.format(notes[i].date,),
                        style: TextStyle(
                          color: Color(0xFFAFB4C6),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  Text(notes[i].content+'...',
                  maxLines: 4,)
                ],
              ),
            ),
          ),
        ),
      ));
    }
    return results;
  }
}
