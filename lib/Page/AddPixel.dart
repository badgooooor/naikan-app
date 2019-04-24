import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:naikan/Model/Model.dart';
class AddPixel extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
        theme: ThemeData(),
        home: AddPixelPage(title: 'Add Snapshot')
    );
  }
}

class AddPixelPage extends StatefulWidget{
  AddPixelPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _AddPixelPage createState() => _AddPixelPage();
}

class _AddPixelPage extends State<AddPixelPage> {
  DateTime _date = new DateTime.now();
  int dateInt = new DateTime.now().year*10000+new DateTime.now().month*100+new DateTime.now().day;
  int happy=0;
  int angry=0;
  int love=0;
  int passive=0;
  int confused=0;
  int sad=0;
  Api api = new Api();

  String getDate(DateTime _date) {
    var month = ['January', 'February', 'March',
    'April', 'May', 'June',
    'July', 'August', 'September',
    'October', 'November', 'December'
    ];
    String str = '';
    str += month[_date.month] + ' ';
    str += _date.day.toString() + ' , ';
    str += _date.year.toString();
    return str;
  }

  display(){
    print('///////////////////////////////////////////////');
    print('date \t=\t'+dateInt.toString());
    print('Happy\t=\t'+happy.toString());
    print('Angry\t=\t'+angry.toString());
    print('Love \t=\t'+love.toString());
    print('Passive\t=\t'+passive.toString());
    print('Confused\t=\t'+confused.toString());
    print('Sad  \t=\t'+sad.toString());
    print('finalEmotion=\t'+getFinalEmotion());
  }
  String getFinalEmotion(){
    String mostEmotion = 'Happier';
    return mostEmotion;
  }
  save() async{
    Map data={
      "angry": angry,
      "confuse": confused,
      "happy": happy,
      "passive": passive,
      "sad": sad,
      "love": love,
      "finalEmotion": getFinalEmotion()
//      ,"date" : 19990326
    };
    print('-------------save-------------');
    http.Response res = await api.postPixel(data);
//    if(res.statusCode != 200){
//      print(res.statusCode);
//      print(res.body);
//    }
    print('------------------------------');

  }
  ///////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(

              getDate(_date), style: new TextStyle(color: Colors.black)),
          backgroundColor: new Color(0xFFFFFFFF),
          centerTitle: false,
        ),
        body: Center(

            child: Column(

                children: [

                  Text('HOW ARE YOU?', style: new TextStyle(
                      color: new Color(0xFFF34949),
                      fontWeight: FontWeight.bold,
                      fontSize: 40),),
                  Row(
                      children: [
                        Column(children: <Widget>[Text('Happy'),IconButton(icon: Icon(Icons.save),onPressed: (){happy+=1;})],),
                        Column(children: <Widget>[Text('Angry'),IconButton(icon: Icon(Icons.save),onPressed: (){angry+=1;})],),
                        Column(children: <Widget>[Text('Love'),IconButton(icon: Icon(Icons.save),onPressed: (){love+=1;})],),
                      ]
                  ),
                  Row(
                      children: [
                        Column(children: <Widget>[Text('Passive'),IconButton(icon: Icon(Icons.save),onPressed: (){passive+=1;})],),
                        Column(children: <Widget>[Text('Confused'),IconButton(icon: Icon(Icons.save),onPressed: (){confused+=1;})],),
                        Column(children: <Widget>[Text('Sad'),IconButton(icon: Icon(Icons.save),onPressed: (){sad+=1;})],),
                      ]
                  ),
                  Text('Feeling of the day', style: new TextStyle(
                      color: new Color(0xFFF34949),
                      fontWeight: FontWeight.bold,
                      fontSize: 40),),
                  IconButton(icon: Icon(Icons.score),onPressed: display,),
                  IconButton(icon: Icon(Icons.add_box),onPressed: save,)
            ])


        )


    );
  }
}