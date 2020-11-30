import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_notes_app_v1/model/notes.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatefulWidget {
  Note note;

  DetailPage({this.note});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final DateFormat _dateFormat = DateFormat('yyyy-mm-dd EEEE');
  File _image;
  final picker = ImagePicker();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _contentController.text = widget.note.content;
    _titleController.text=widget.note.title;
  }

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    double width=size.width;
    double height=size.height;
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //
        //
        //   title: Text(
        //     widget.note.title,
        //     style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        //   ),
        //   backgroundColor: Colors.white,
        //   iconTheme: IconThemeData(color: Colors.black),
        //   actions: [
        //     IconButton(icon: Icon(Icons.image), onPressed: getImage),
        //     IconButton(
        //         icon: Icon(Icons.star,
        //             color: widget.note.important ? Colors.amber : Colors.grey),
        //         onPressed: () {
        //           setState(() {
        //             //추가필요
        //           });
        //         })
        //   ],
        // ),
        body: Column(
          children: [
            Container(
              child: Stack(
                children: [
                  Container(
                    width: width,
                    height: height*0.03,
                    color: Colors.blueAccent,
                  ),
                  Container(
                    width: width,
                    height: height*0.10,

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
                              fontSize: 30
                            ),
                          ),
                        ),
                        IconButton(icon: Icon(Icons.image,
                        color: Colors.white,), onPressed: getImage),
                        IconButton(icon: Icon(Icons.star), onPressed: (){})
                      ],
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(
                  color: Colors.black54,
                  blurRadius:20
                )]
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _image == null ? Container() : Image.file(_image),
                      TextField(
                        controller: _contentController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(border: InputBorder.none),
                        style: TextStyle(
                          fontSize: 18
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(_dateFormat.format(widget.note.date),
                            style: TextStyle(color: Colors.grey)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future getImage() async {
    final pickFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickFile.path);
    });
  }
}
