import 'package:flutter/material.dart';
import 'pixelCalendar.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  var loginDialog;

  var username;
  var password;

  Future _login() {
    setState(() {
      print('Logging in with username: '+(username==null?'NULL':username)+'\tpassword: '+(password==null?'NULL':password));
      if(username!=null&&password!=null){
        print('Logged in as $username with password $password');
        loginDialog = 'Logging in Completed';
        runApp(PixelCalendarSet());
      }
      else {
        print('Logging in failed: Invalid Username or Password');
        loginDialog = 'Logging in failed: Invalid Username or Password';
      }
    });
    return showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          content: Text(loginDialog),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,

      body: new Stack(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                  image: AssetImage('image/background.jpg'),
                  fit: BoxFit.fill
              ),
            ),
          ),
          new Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(64.0, 120.0, 64.0, 4.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: new TextStyle(color: Colors.white),
                    ),
                    textAlign: TextAlign.center,
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.text,
                    onChanged: (value){
                      username=value.isEmpty?null:value;
                      print('entered username: '+value);
                    },
                    style: TextStyle(color: Colors.white),

                  ),
                ),
                Padding(
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
                ),
              ],
            ),
          )
        ],

      ),
    );
  }
}