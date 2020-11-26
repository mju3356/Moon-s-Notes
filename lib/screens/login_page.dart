import 'package:flutter/material.dart';
import 'dart:ui';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _startTime = false;
  bool _endTime = false;

  _LoginPageState() {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _startTime = true;
      });
    });
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _endTime = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height=size.height;
    double width=size.width;

    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          AnimatedPositioned(
            top: _startTime ? height*0.1 : height*0.5,
            left: width*0.18,
            curve: Curves.easeInBack,
            duration: Duration(seconds: 1),
            child: CircleAvatar(
              radius: 130,
              backgroundImage: AssetImage('images/logo.png'),
            ),
          ),
          Positioned(
            top: height*0.7,
              left:width*0.12,
              child: AnimatedOpacity(
            duration: Duration(seconds: 1),
            opacity: _endTime ? 1 : 0,
            child: _loginButton(),
          ))
        ],
      ),
    ));
  }

  Widget _loginButton() {
    return ButtonTheme(
      height: 50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: RaisedButton(
        onPressed: () {},
        child: SizedBox(
          width: 280,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _makeGoogleLogo(),
              Text(
                'Sign In With GOOGLE',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Opacity(
                opacity: 0,
                child: _makeGoogleLogo(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _makeGoogleLogo() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 35,
          width: 35,
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        ),
        SizedBox(
          height: 30,
          width: 30,
          child: Image.asset('images/google.png'),
        )
      ],
    );
  }
}
