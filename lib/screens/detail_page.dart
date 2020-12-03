import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_notes_app_v1/model/notes.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatefulWidget {
  final int num;
  Function(int) callbackImportant;
  Function callbackImage;


  DetailPage({this.num, this.callbackImportant,this.callbackImage});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd EEEE');
  final picker = ImagePicker();
  bool _showDelete=false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _contentController.text = notes[widget.num].content;
    _titleController.text = notes[widget.num].title;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return SafeArea(
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: Column(
            children: [
              Container(
                child: Stack(
                  children: [
                    Container(
                      width: width,
                      height: height * 0.03,
                      color: Colors.blueAccent,
                    ),
                    Container(
                      width: width,
                      height: height * 0.10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blueAccent,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _titleController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: width*0.08),
                              onChanged: (text) {
                                notes[widget.num].title = text;
                              },
                            ),
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.image,
                                color: Colors.white,
                              ),
                              onPressed: getImage),
                          IconButton(
                              icon: Icon(
                                Icons.star,
                                color: notes[widget.num].important
                                    ? Colors.amber
                                    : Colors.grey,
                              ),
                              onPressed: () {

                                setState(() {
                                  widget.callbackImportant(widget.num);
                                });
                              })
                        ],
                      ),
                    )
                  ],
                ),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(color: Colors.black54, blurRadius: 20)
                ]),
              ),
              Expanded(
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        notes[widget.num].image == null ? Container() : showImage(),
                        TextField(
                          controller: _contentController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(border: InputBorder.none),
                          style: TextStyle(fontSize: width*0.05),
                          onChanged: (text) {
                            notes[widget.num].content = text;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(_dateFormat.format(notes[widget.num].date),
                              style: TextStyle(color: Colors.grey,
                              fontSize: width*0.04)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget showImage(){
    return GestureDetector(
      onTap: () {
        setState(() {
          _showDelete = true;
     Future.delayed(Duration(seconds: 3),() {
            setState(() {
              _showDelete=false;

            });
          });
        });
      },
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Image.file(notes[widget.num].image),
            _showDelete?Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){
                  setState(() {
                    widget.callbackImage(widget.num,null);
                  });
                },
                child: Container(

                  alignment: Alignment.center,
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red
                  ),
                  child: Text('X',
                  style: TextStyle(color: Colors.white),),
                ),
              ),
            ):Container(),

          ],
        ),
      
    );
  }

  Future getImage() async {
    final pickFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      widget.callbackImage(widget.num,File(pickFile.path));
    });
  }
}
