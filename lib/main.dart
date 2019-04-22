import 'package:flutter/material.dart';
import 'login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Naikan',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: LoginPage(title: 'Naikan_Login'),
    );
  }
}
