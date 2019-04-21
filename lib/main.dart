import 'package:flutter/material.dart';

void main(){
  // const PrimaryColor = const Color(0xF34949);
  runApp(MaterialApp(
    title: 'test',
    home: Body(),
    
    // theme: ThemeData(
    //   primaryColor: PrimaryColor,
    // ),
 
  ));
}

class Body extends StatelessWidget{
  //static const PrimaryColor = const Color(0xFFFFFF100);
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: new Color(0xFFF34343),
       // backgroundColor: PrimaryColor,
        centerTitle: true ,
        title: Text('SNAPSHOT'),
      ),
      body: BodyContent(),
    );
  }

}

class BodyContent extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('tao'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('tao'),
            ],
          ),
        ],
      ),
    );
  }



}