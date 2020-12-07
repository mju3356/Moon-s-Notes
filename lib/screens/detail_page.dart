import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_notes_app_v1/model/notes.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatefulWidget {
  Function callbackNote;
  Note note;
  int num;

  DetailPage({this.note, this.num, this.callbackNote});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd EEEE');
  final picker = ImagePicker();
  bool _showDelete = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _contentController.text = widget.note.content;
    _titleController.text = widget.note.title;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return SafeArea(
      child: GestureDetector(
        onTap: () {
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
                      height: height * 0.09,
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
                                  fontSize: width * 0.08),
                              onChanged: (text) {
                                widget.note.title = text;
                                widget.callbackNote(
                                    widget.num,
                                    widget.note);
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
                                color: widget.note.important
                                    ? Colors.amber
                                    : Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  widget.note.important=!widget.note.important;
                                  widget.callbackNote(
                                      widget.num,
                                      widget.note);
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
                        widget.note.image == null ? Container() : showImage(),
                        TextField(
                          controller: _contentController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(border: InputBorder.none),
                          style: TextStyle(fontSize: width * 0.05),
                          onChanged: (text) {
                            widget.note.content = text;
                            widget.callbackNote(
                                widget.num,
                              widget.note
                            );
                            // Note.saveNote(notes);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(_dateFormat.format(widget.note.date),
                              style: TextStyle(
                                  color: Colors.grey, fontSize: width * 0.04)),
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

  Widget showImage() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showDelete = true;
          Future.delayed(Duration(seconds: 3), () {
            setState(() {
              _showDelete = false;
            });
          });
        });
      },
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Image.file(widget.note.image),
          _showDelete
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        widget.note.image=null;
                        widget.callbackNote(
                            widget.num,
                           widget.note);;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.red),
                      child: Text(
                        'X',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Future getImage() async {
    final pickFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      widget.note.image=File(pickFile.path);
      widget.callbackNote(
      widget.num,
      widget.note);
    });
  }
}
