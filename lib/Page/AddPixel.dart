import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:naikan/Model/Model.dart';
import 'package:sortedmap/sortedmap.dart';

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
    String mostEmotion = 'Happy';
    // var map = new SortedMap();
    // map.addEntries({'happy':happy});
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
        backgroundColor: Color(0xFFFFFFFF),
        bottomNavigationBar: Footerr(),
        appBar: AppBar(
          
          leading: IconButton(
            padding: EdgeInsets.only(
              left: 5
            ),
            icon: Icon(Icons.date_range,size: 25,color: Colors.black45,),
            onPressed:(){
              print('select date');
            },
          ),
          titleSpacing: 0,
          title: new Text(
          
              getDate(_date), style: new TextStyle(
                color: Colors.black45,
                fontFamily: 'Cooper',
                fontSize: 18.0,
                
                
                )),
          backgroundColor: new Color(0xFFF34949),
          
        ),
        body: Container(
            
            child: Column(
                
                children: [
                  Container(
                    height: 100,
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
                    height: 25,
                  ),

                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                          
                          Text('Happy', style: new TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.red[900],
                            fontWeight: FontWeight.bold
                          )),
                          GestureDetector(
                            onTap: (){
                              happy+=1;
                            },
                            child: Image(
                              image: AssetImage('assets/moodpixel/Group35.png'),width: 80,
                            )
                          ),
                          // IconButton(icon: Icon( IconData(0xe900, fontFamily: 'happy')),onPressed: (){happy+=1;})
                            ],),
                          Container(
                            width: 15,
                          ),
                        Column(
                          children: <Widget>[
                          Text('Angry',style: new TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.red[900],
                            fontWeight: FontWeight.bold
                          )),
                          GestureDetector(
                            onTap: (){
                              angry+=1;
                            },
                            child: Image(
                              image: AssetImage('assets/moodpixel/Group36.png'),width: 80,
                            )
                          ),
                          ],),
                          Container(
                            width: 15,
                          ),
                        Column(
                          children: <Widget>[
                          Text('Love',style: new TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.red[900],
                            fontWeight: FontWeight.bold
                          )),
                          GestureDetector(
                            onTap: (){
                              love+=1;
                            },
                            child: Image(
                              image: AssetImage('assets/moodpixel/Group37.png'),width: 80,
                            )
                          ),
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
                          Text('Neutral',style: new TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.red[900],
                            fontWeight: FontWeight.bold
                          )),
                          GestureDetector(
                            onTap: (){
                              passive+=1;
                            },
                            child: Image(
                              image: AssetImage('assets/moodpixel/Group38.png'),width: 80,
                            )
                          ),
                          ],),
                          Container(
                            width: 15,
                          ),
                        Column(
                          children: <Widget>[
                          Text('Confused',style: new TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.red[900],
                            fontWeight: FontWeight.bold
                          )),
                          GestureDetector(
                            onTap: (){
                              confused+=1;
                            },
                            child: Image(
                              image: AssetImage('assets/moodpixel/Group39.png'),width: 80,
                            )
                          ),
                          ],),
                          Container(
                            width: 15,
                          ),
                        Column(
                          children: <Widget>[
                          Text('Sad',style: new TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.red[900],
                            fontWeight: FontWeight.bold
                          )),
                          GestureDetector(
                            onTap: (){
                              sad+=1;
                            },
                            child: Image(
                              image: AssetImage('assets/moodpixel/Group40.png'),width: 80,
                            )
                          ),
                          ],),
                      
                      ]
                  ),
                  Container(
                    height: 25,
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
                    ),
                    ),
                    Container(
                    height: 20,
                  ),
                    Container(
                      decoration: new BoxDecoration(
                        color: Color(0xFFF7A8A8),
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      ),
                      width: 350,
                      height: 80,
                      
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              left: 0
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              display();
                            },
                            child: Image(
                            image: AssetImage('assets/moodpixel/Group 36.png'),
                            width: 80,
                            height: 80,
                          
                            )
                          ),
                          
                        ],
                         
                      ),
                    ),
                    Container(
                    height: 30,
                  ),
                  GestureDetector(
                            onTap: (){
                              save();
                            },
                            child: Image(
                              image: AssetImage('assets/moodpixel/update.png'),height: 65,
                            )
                          ),

            ])


        )
        


    
    );
  }

}
class Footerr extends StatefulWidget{
  @override
  FooterrState createState(){
    return new FooterrState();
}

}
class FooterrState extends State<Footerr>{
  @override
  Widget build(BuildContext context){
    return Container(
      
      width: 370,
      height: 54,
      color: new Color(0xFFF34949),
      child: new Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              left: 45
            ),
            child:
            new IconButton(
              icon: Icon(Icons.home,color: Colors.white30,size: 30,),
              onPressed: (){
                print('home');
              },
            )
            
          ),
          Container(
            margin: EdgeInsets.only(
              left: 45
            ),
            child:
            new IconButton(
              icon :Icon(Icons.edit,color: Colors.white30,size: 30),
              onPressed: (){
                print('addsnap');
              },
            )
          
          ),
          Container(
            margin: EdgeInsets.only(
              left: 45
            ),
            child:
             new IconButton(
              icon: Icon(Icons.favorite,color: Colors.white30,size: 30),
              onPressed: (){
                print('snap');
              },
            )
            
            ),
          Container(
            margin: EdgeInsets.only(
              left: 45
            ),
            child:
            new IconButton(
              icon:Icon(Icons.settings,color: Colors.white30,size: 30),
              onPressed: (){
                print('setting');
              },
            )
           
          ),
          
        
        ],
      ),
    );
  }
}
