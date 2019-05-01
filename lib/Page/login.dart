import 'package:flutter/material.dart';
import './Page.dart';
class LoginStateSet extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Naikan',
      theme: ThemeData(
          primarySwatch: Colors.red,
          hintColor: Colors.white,
          fontFamily: 'Leelawadee'
      ),
      home: LoginPage(title: 'Naikan_Login'),
      initialRoute: '/',
      routes: {
        '/addpixel' : (context) => AddPixelPage()
      },
    );
  }
}

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
        if(username=='naikan'&&password=='naikan') {
          print('Logged in as $username with password $password');
          loginDialog = 'Logging in Completed';
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPixel()));
        }
        else{
          print('Username $username or password $password is not matched');
          loginDialog = 'Logging in failed: Wrong Username or Password';
        }
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
            margin: EdgeInsets.only(
              left: 148,
              top: 100

            ),
            child : Image(
            image: AssetImage('assets/cherry.png'),
            height: 100,
          ),
          ),
          
         
            
          new Container(
            margin: EdgeInsets.only(
              top: 350
            ),
            decoration: new BoxDecoration(
              color: Colors.red[400],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(120.0),
                topRight: Radius.circular(120.0)
              )
              //borderRadius: BorderRadius.all(Radius.circular(100.0)),
            ),
            width: 410,
            height: 870,
            // decoration: new BoxDecoration(
            //   image: new DecorationImage(
            //       image: AssetImage('assets/Login_background.jpg'),
            //       fit: BoxFit.fill
            //   ),
            // ),
          ),
          
          new Center(
         
            
            child: Container(
              
              
              margin: EdgeInsets.only(
                top: 200
              ),
              decoration: new BoxDecoration(
                color: Colors.red[400],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(120.0),
                  topRight: Radius.circular(120.0)
                )
                //borderRadius: BorderRadius.all(Radius.circular(100.0)),
              ),
              width: 410,
              height: 870,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(64.0, 74.0, 64.0, 4.0),
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
                  padding: const EdgeInsets.fromLTRB(64.0, 30.0, 64.0, 35.0),
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
                Container(
                  height: 0,
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
            ),
            
            
              
          )
        ],

      ),
    );
  }
}