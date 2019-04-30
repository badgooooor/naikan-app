import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:naikan/Model/Model.dart';
import 'package:naikan/Page/footer.dart';
import 'package:sortedmap/sortedmap.dart';
import 'Save.dart';

DateTime _date = new DateTime.now();
class AddpixelPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'addpixel',
      theme: ThemeData(
          primarySwatch: Colors.red,
          hintColor: Colors.white,
          fontFamily: 'Leelawadee'
      ),
      home: AddPixel(),
    
      routes: {
      // When we navigate to the "/" route, build the FirstScreen Widget
      'addpixel': (context) => AddPixel(),
    },
      
    );
  }
}


class AddPixel extends StatelessWidget{

  void setDate(DateTime dateTime){
    _date=dateTime;
  }

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


  int dateInt = _date.year*10000+_date.month*100+_date.day;
  int happy=Save.happy;
  int angry=Save.angry;
  int love=Save.love;
  int passive=Save.passive;
  int confused=Save.passive;
  int sad=Save.sad;
  List<String> _emo=[];
  Api api = new Api();
  String _imgFinalEmotion = Save.finalEmotion;//'Group 36';
  Map<String,String> pathImgFinalEmotino = {
    'happy':'Group35',
    'angry':'Group36',
    'love':'Group37',
    'passive':'Group38',
    'confuse':'Group39',
    'sad':'Group40'
  };


  String getDate(DateTime _date) {
    var month = ['January', 'February', 'March',
    'April', 'May', 'June',
    'July', 'August', 'September',
    'October', 'November', 'December'
    ];
    String str = '';
    str += month[_date.month-1] + ' ';
    str += _date.day.toString() + ' , ';
    str += _date.year.toString();
    return str;
  }

  // String
  String percentage(int emotion){
      // int x = 
      if(happy+angry+love+passive+confused+sad == 0)
        return '0';
      return ((emotion/(happy+angry+love+passive+confused+sad))*100).toInt().toString();
      // return x.toString();
  }

  display(){
    print('///////////////////////////////////////////////');
    print('date \t=\t'+dateInt.toString());
    print('Happy\t=\t'+happy.toString()+'\t'+percentage(happy));
    print('Angry\t=\t'+angry.toString()+'\t'+percentage(angry));
    print('Love \t=\t'+love.toString()+'\t'+percentage(love));
    print('Passive\t=\t'+passive.toString()+'\t'+percentage(passive));
    print('Confused\t=\t'+confused.toString()+'\t'+percentage(confused));
    print('Sad  \t=\t'+sad.toString()+'\t'+percentage(sad));
    print('finalEmotion=\t'+getFinalEmotion());
  }
  String getFinalEmotion(){
    // print('emo=\t'+_emo.toString());
    List temp = [happy,angry,love,passive,confused,sad];
    List tempStr = ['happy','angry','love','passive','confuse','sad'];
    List maxList = [];
    int max = 0,sizeMax = 0,maxIndex=-1;
     for(int i = 0 ;i < temp.length ; i++){
      if(temp[i] > sizeMax) 
        sizeMax = temp[i];
    }
    for(int i = 0 ;i < temp.length ; i++){
      if(temp[i] == sizeMax) {
          max+=1;
          maxIndex=i;
          maxList.add(tempStr[i]);
      }
    }
    if(max != 1){
      // print('maxSize =\t'+sizeMax.toString());
      // print('max emotion =\t'+max.toString());
      // print('maxList =\t'+maxList.toString());
      // print(maxIndex);
      for(int i = _emo.length-1 ; i >= 0 ; i--){
        if(maxList.contains(_emo[i]))
          // print(_emo[i]);
          return _emo[i];
      }
    }
    // print(tempStr[maxIndex]);
    return tempStr[maxIndex]; 
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
        body: new Stack( children:[
          Container(         
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
                              setState(() {
                              happy+=1;
                              Save.happy+=1;
                              _emo.add('happy');
                              // print('Save is here !!!! = '+ Save.happy.toString());
                              String pathEmo = pathImgFinalEmotino[getFinalEmotion()];
                              _imgFinalEmotion = pathEmo;
                              Save.finalEmotion = pathEmo;
                              });
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
                              _emo.add('angry');
                              Save.angry+=1;
                              setState(() {
                                String pathEmo = pathImgFinalEmotino[getFinalEmotion()];
                                _imgFinalEmotion = pathEmo;
                                Save.finalEmotion = pathEmo;
                              });
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
                              _emo.add('love');
                              Save.love+=1;
                              setState(() {
                                String pathEmo = pathImgFinalEmotino[getFinalEmotion()];
                                _imgFinalEmotion = pathEmo;
                                Save.finalEmotion = pathEmo;
                              });
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
                              _emo.add('passive');
                              Save.passive+=1;
                              setState(() {
                              String pathEmo = pathImgFinalEmotino[getFinalEmotion()];
                              _imgFinalEmotion = pathEmo;
                              Save.finalEmotion = pathEmo;
                              });
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
                              _emo.add('confuse');
                              Save.confused+=1;
                              setState(() {
                                String pathEmo = pathImgFinalEmotino[getFinalEmotion()];
                                _imgFinalEmotion = pathEmo;
                                Save.finalEmotion = pathEmo;
                              });
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
                              _emo.add('sad');
                              Save.sad+=1;
                              setState(() {
                                String pathEmo = pathImgFinalEmotino[getFinalEmotion()];
                                _imgFinalEmotion = pathEmo;
                                Save.finalEmotion = pathEmo;
                              });
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
                    // margin: EdgeInsets.only(
                    //   // left: 100
                    // ),

                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                      // decoration: new BoxDecoration(
                      //   color: Color(0xFFF7A8A8),
                      //   borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      // ),
                      // width: 350,
                      // height: 80,
                      margin: EdgeInsets.only(
                        top: 10
                      ),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              left: 57.79,
                     
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                            if(sad+happy+confused+passive+angry+love!=0){
                              display();
                              }
                              api.getPixelToday();
                            },
                            child: Image(
                            image: AssetImage('assets/moodpixel/$_imgFinalEmotion.png'),
                            width: 80,
                            height: 80,
                          
                            )
                          ),
                          new Column(
                            children: <Widget>[
                              Container(
                              margin: EdgeInsets.only(
                                left: 26),
                              width: 30,
                              height: 24,
                              color: Color(0xFFFFE26E),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(percentage(happy),style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                              ),)
                              ],
                            )
                          ),
                          Container(
                            height: 15,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: 23.21),
                            width: 30,
                            height: 24,
                            color: Color(0xFF68E88E),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(percentage(passive),style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                             ),)
                              ],
                            )
                          ),
                  
                         
                            ],
                          ),
                           new Column(
                            children: <Widget>[
                              Container(
                            margin: EdgeInsets.only(
                              left: 23.21),
                            width: 30,
                            height: 24,
                            color: Color(0xFFFF3A3A),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(percentage(angry),style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                             ),)
                              ],
                            )
                          ),
                          Container(
                            height: 15,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: 23.21),
                            width: 30,
                            height: 24,
                            color: Color(0xFFDD78FB),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(percentage(confused),style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                             ),)
                              ],
                            )
                          ),
                         
                            ],
                          ),
                           new Column(
                            children: <Widget>[
                              Container(
                            margin: EdgeInsets.only(
                              left: 23.21),
                            width: 30,
                            height: 24,
                            color: Color(0xFFFF7596),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(percentage(love),style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                             ),)
                              ],
                            )
                          ),
                          Container(
                            height: 15,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: 23.21),
                            width: 30,
                            height: 24,
                            color: Color(0xFF5A5151),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(percentage(sad),style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                             ),)
                              ],
                            )
                          ),
                         
                            ],
                          )
                          
                          
                          
                        ],
                         
                      ),
                    ),
                    Container(
                    height: 30,
                  ),
                  GestureDetector(
                          //.########....###.....#######.
                          //....##......##.##...##.....##
                          //....##.....##...##..##.....##
                          //....##....##.....##.##.....##
                          //....##....#########.##.....##
                          //....##....##.....##.##.....##
                          //....##....##.....##..#######.
                          //tao
                            onTap: ()async{
                            if(sad+happy+confused+passive+angry+love!=0){
                              await save(); 
                                                        
                              }
                            else{
                              //tao implement here
                              // 
                            }
                            },
                            child: Image(
                              image: AssetImage('assets/moodpixel/update.png'),height: 65,
                            )
                          ),

            ])
          ),
          new Footer()
        ]
    )


    
    );
  }

}
