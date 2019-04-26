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
          leading: IconButton(
            icon: Icon(Icons.date_range,size: 25,color: Colors.black54,),
            onPressed:(){
              print('select date');
            },
          ),
          titleSpacing: 0,
          title: new Text(
          
              getDate(_date), style: new TextStyle(
                color: Colors.black54,
                fontFamily: 'Cooper',
                fontSize: 18.0,
                
                
                )),
          backgroundColor: new Color(0xFFFFFFFF),
          
        ),
        body: Container(

            child: Column(
                
                children: [
                  Container(
                    height: 85,
                  ),
                  Text('HOW ARE YOU?', style: new TextStyle(
                      fontFamily: 'Cooper',
                      color: new Color(0xFFC43A3A),
                      fontSize: 36,
                      shadows:<Shadow>[
                        Shadow(
                        offset: Offset(3, 3),
                        blurRadius: 2.0,
                        color: Colors.black12
                              )
                          ]
                      ),
                  ),
                  Container(
                    height: 15,
                  ),
                  
                      
                
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                          Text('Happy', style: new TextStyle(
                            
                          )),
                          
                          IconButton(icon: Icon(Icons.),onPressed: (){happy+=1;})
                           ],),
                          Container(
                            width: 22,
                          ),
                        Column(
                          children: <Widget>[
                          Text('Angry',style: new TextStyle(

                          )),
                          IconButton(icon: Icon(Icons.save),onPressed: (){angry+=1;})
                          ],),
                          Container(
                            width: 22,
                          ),
                        Column(
                          children: <Widget>[
                          Text('Love',style: new TextStyle(

                          )),
                          IconButton(icon: Icon(Icons.save),onPressed: (){love+=1;})
                          ],)
                      ]
                  ),

                  Container(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        
                        Column(
                          children: <Widget>[
                          Text('Passive',style: new TextStyle(

                          )),
                          IconButton(icon: Icon(Icons.save),onPressed: (){passive+=1;})
                          ],),
                          Container(
                            width: 15,
                          ),
                        Column(
                          children: <Widget>[
                          Text('Confused',style: new TextStyle(

                          )),
                          IconButton(icon: Icon(Icons.save),onPressed: (){confused+=1;})
                          ],),
                          Container(
                            width: 15,
                          ),
                        Column(
                          children: <Widget>[
                          Text('Sad',style: new TextStyle(

                          )),
                          IconButton(icon: Icon(Icons.save),onPressed: (){sad+=1;})
                          ],),
                      
                      ]
                  ),
                  Container(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 57
                    ),

                    child: new Row(
                      children: <Widget>[
                         new Text('Feeling of the day', style: new TextStyle(
                          color: new Color(0xFFC43A3A),
                          fontFamily: 'Cooper',
                          shadows:<Shadow>[
                            Shadow(
                            offset: Offset(3, 3),
                            blurRadius: 2.0,
                            color: Colors.black12
                                  )
                              ],
                          fontSize: 20),
                          ),
                      ],
                    )),
                  IconButton(icon: Icon(Icons.score),onPressed: display,),
                  IconButton(icon: Icon(Icons.add_box),onPressed: save,)
            ])


        )


    
    );
  }

}