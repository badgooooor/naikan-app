import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class PixelCalendarSet extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Naikan',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: PixelCalendar(title: 'Naikan_PixelCalendar'),
    );
  }
}

class PixelCalendar extends StatefulWidget {
  PixelCalendar({Key key, this.title}) : super(key: key);

  final String title;

  @override
  CalendarState createState() => CalendarState();
}

class CalendarState extends State<PixelCalendar> {

  void _Calendar() {
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,

      body: new Stack(
        children: <Widget>[
          /*new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                  image: AssetImage('image/background.jpg'),
                  fit: BoxFit.fill
              ),
            ),
          ),*/
          new Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 250, 0, 50),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 250, 0, 50),
                      child: Text('Pixel Calendar')
                  )
                ),
                /*Padding(
                  padding: const EdgeInsets.fromLTRB(64.0, 4.0, 64.0, 35.0),
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: new TextStyle(color: Colors.white)
                    ),
                    textAlign: TextAlign.center,
                    cursorColor: Colors.white,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    onChanged: (value){
                      password=value.isEmpty?null:value;
                      print('entered password: '+value);
                    },
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                RaisedButton(
                  color: Colors.white,
                  textColor: Colors.red,
                  child: Text(
                    'LOGIN',
                  ),
                  onPressed: _login,
                  padding: const EdgeInsets.fromLTRB(96, 4, 96, 4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),*/
              ],
            ),
          )
        ],

      ),
    );
  }
}