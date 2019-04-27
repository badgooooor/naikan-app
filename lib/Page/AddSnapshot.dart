import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:naikan/Model/Model.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class AddSnapshot extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
        theme: ThemeData(

        ),
        home: HomePage(title:'AddSnapshot')
    );
  }
}

class HomePage extends StatefulWidget{
  HomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  var color = Colors.red;
  String name = "";
  String story = "";
  String where = "";
  DateTime _date = new DateTime.now();
  int dateInt = new DateTime.now().year*10000+new DateTime.now().month*100+new DateTime.now().day;
  TimeOfDay _time = new TimeOfDay.now();
  File image;
  Api api = new Api();
  
  DateTime test_ym = new DateTime.now();

  void _display(){
    setState(() {
      if (color == Colors.red){
        color = Colors.blue;
      }
      else {
        color = Colors.red;
      }
    });
    print('--------------------------------------------');
    print('title  = '+name);
    print('detial = '+story);
    print('time =  '+ _time.toString().substring(10,15));
    print('place = '+where);
    print('date =  '+dateInt.toString());//${_date.toString()}');
    print('image=');
    print(image==null?null:image.path);
  }

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

  save() async{ 
    Map data={
        "title":name,
        "detail":story,
        "time":_time.toString().substring(10,15),
        "place":where,
        "date":dateInt+100,
        "pic":image==null?null:image.path
    };
    print('--------------------save--------------------');
     http.Response res = await api.postSnapshot(data);
    //  print(res.statusCode);
    print('--------------------------------------------');
  }

  getSnapshot()async{
    // http.Response res = await api.getSnapshotDate(20190425);
    // print(json.decode(res.body)['date']);
    // Snapshot x = await api.getSnapshotDate(20190425);
    // print(x.toString());
    // List<Snapshot> snaps =  await api.getSnapshotAll();
    // print(snaps); 
    List<Snapshot> snaps =  await api.getSnapshotYearMonth(2019,5);
    print(snaps); 
  }
  Future<Null> selectDate(BuildContext context) async{
    final DateTime pickedDateTime = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(2019),
        lastDate: new DateTime(2020)
    );
    if (pickedDateTime != null && pickedDateTime != _date){
      setState(() {
        _date = pickedDateTime;
      });
    }
  }

  Future<Null> selectTime(BuildContext context) async{
    final TimeOfDay pickedTime = await showTimePicker(
        context: context,
        initialTime: _time);
    if(pickedTime != null){
      setState(() {
        _time = pickedTime;
      });
    }
  }
  Future<Null> selectYearMonth(BuildContext context) async{
    final DateTime pickedYearMonth = await showMonthPicker(
      context: context,initialDate: DateTime(2019)
    );
        if(pickedYearMonth != null){
      setState(() {
        test_ym = pickedYearMonth;
        print(test_ym);
      });
    }
  }
  selectImage() async{
    File img = await ImagePicker.pickImage(source: ImageSource.gallery);
    print('/////////////////path_image in selectImage()');
    print(img==null?null:img.path);
    setState(() {
      image = img;
    });
  }
  ///////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context){
    return Scaffold(
      
        appBar: AppBar(
          
                leading: new IconButton(
          icon : Icon(Icons.chevron_left,size:30,color: Colors.white70,),
          onPressed: (){
            print('backk');
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.date_range,size:30,color: Colors.white70),
            onPressed: (){
              print('Calendar');
            },
          )
        ],
          titleSpacing: 0,
          title: new Text(
              
              getDate(_date), style: new TextStyle(
                color: Colors.white70,
                fontFamily: 'Cooper',
                fontSize: 20.0,
                
                
                )),
          backgroundColor: new Color(0xFFF34949),
          centerTitle: true,
      ),
      body: Center(
        
        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.only(
                left: 95
              ),
              
              child:
              Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(
                    image: AssetImage('assets/heart.png'),
                    height: 35,
                  ),
                  Text(
                    'SNAPSHOT',style: new TextStyle(
                      fontFamily: 'Cooper',
                      color: new Color(0xFFC43A3A),
                      fontSize: 30,
                      shadows:<Shadow>[
                        Shadow(
                        offset: Offset(3, 3),
                        blurRadius: 2.0,
                        color: Colors.black12
                              )
                          ]
                      ),
                  )
                ],
              ),
               

            ),
            Container(
              child: TextField(
                keyboardType: TextInputType.text,                                                                                                                                     
                // textInputAction: TextInputAction.continueAction,
                textAlign: TextAlign.left,
                style: TextStyle(color:Colors.red[400], fontSize: 15),
                maxLength: 30,
                cursorColor: Colors.red[400],
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.title,color: Colors.red[300],),
                  hintText: "Title",
                ),
                onChanged: (text){
                  name = text;
                },
              ),
            ),
            
            
            TextField(
              keyboardType: TextInputType.text,
              // textInputAction: TextInputAction.continueAction,
              textAlign: TextAlign.left,
              style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 20),
              // maxLines: 4,
              maxLength: 280,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.book),
                hintText: "    What's happening?",
              ),
              onChanged: (text){
                story = text;
              },
            ),
            FlatButton(
                child: new Text('When?',style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 20) ,),
                onPressed: (){selectTime(context);}
            ),          

            TextField(
              keyboardType: TextInputType.text,
              // textInputAction: TextInputAction.continueAction,
              textAlign: TextAlign.left,
              style: TextStyle(color: color, fontWeight: FontWeight.w800, fontSize: 20),
              maxLength: 30,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.location_on),
                hintText: "Where?",
              ),
              onChanged: (text){
                where = text;
              },
            ),
            FlatButton(
              child: new Text('Add photo?',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600,fontSize: 20 )),
              onPressed: selectImage,
            ),
            image!=null?new Image.file(image,width: 100,height: 100):new Text('select your image'),
            FlatButton(
              child: new Text('Save?',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600,fontSize: 20 )),
              onPressed: save,
            ),
            FlatButton(
              child: new Text('for test?',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600,fontSize: 20 )),
              onPressed: (){selectYearMonth(context);},//getSnapshot,
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _display,
          child: Icon(Icons.save)
      ),
    );
  }


}