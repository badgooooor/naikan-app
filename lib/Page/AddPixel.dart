import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:naikan/Model/Model.dart';
import 'package:naikan/Page/footer.dart';
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
  List<String> _emo=[];
  Api api = new Api();
  String _imgFinalEmotion = 'Group 36';
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
    str += month[_date.month] + ' ';
    str += _date.day.toString() + ' , ';
    str += _date.year.toString();
    return str;
  }

  // String
  String percentage(int emotion){
      // int x = 
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
                              _emo.add('happy');
                              _imgFinalEmotion = pathImgFinalEmotino[getFinalEmotion()];
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
                              setState(() {
                                _imgFinalEmotion = pathImgFinalEmotino[getFinalEmotion()];
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
                              setState(() {
                                _imgFinalEmotion = pathImgFinalEmotino[getFinalEmotion()];
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
                              setState(() {
                                _imgFinalEmotion = pathImgFinalEmotino[getFinalEmotion()];
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
                              setState(() {
                                _imgFinalEmotion = pathImgFinalEmotino[getFinalEmotion()];
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
                              setState(() {
                                _imgFinalEmotion = pathImgFinalEmotino[getFinalEmotion()];
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
                            if(sad+happy+confused+passive+angry+love!=0){
                              display();
                              }
                            },
                            child: Image(
                            image: AssetImage('assets/moodpixel/$_imgFinalEmotion.png'),
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
                            if(sad+happy+confused+passive+angry+love!=0){
                              save();                           
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
