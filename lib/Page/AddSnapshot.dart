import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:naikan/Model/Model.dart';
import 'package:naikan/Page/footer.dart';
import 'dart:convert';

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
  String time = "When?";
  DateTime _date = new DateTime.now();
  int dateInt = new DateTime.now().year*10000+new DateTime.now().month*100+new DateTime.now().day;
  TimeOfDay _time = new TimeOfDay.now();
  File image;
  Api api = new Api();
  var colorTime = Colors.grey;
  void _display(){
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
    str += month[_date.month-1] + ' ';
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
        "date":dateInt,
        "pic":image==null?null:image.path
    };
    print('--------------------save--------------------');
     http.Response res = await api.postSnapshot(data);
    //  print(res.statusCode);
    print('--------------------------------------------');
  }

  // getSnapshot()async{
  //   // http.Response res = await api.getSnapshotDate(20190425);
  //   // print(json.decode(res.body)['date']);
  //   // Snapshot x = await api.getSnapshotDate(20190425);
  //   // print(x.toString());
  //   List<Snapshot> snaps =  await api.getSnapshotAll();
  //   // print(snaps[0]); 
  // }
  Future<Null> selectDate(BuildContext context) async{
    final DateTime pickedDateTime = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(2019),
        lastDate: new DateTime(2020)
    );
    if (pickedDateTime != null /*&& pickedDateTime != _date*/){
      setState(() {
        _date = pickedDateTime;
        dateInt = _date.year*10000+_date.month*100+_date.day;
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
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.date_range,size:30,color: Colors.white70),
            onPressed: (){
              print('Calendar');
              selectDate(context);
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
      body: new Stack(
        children:[
          Container(
            width: double.infinity,
            child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.start,
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
               mainAxisAlignment: MainAxisAlignment.start,
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
                  border: UnderlineInputBorder(
                    
                    borderSide: BorderSide(
                      color: Colors.red[300]
                    )
                  )
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
              style: TextStyle(color: color, fontSize: 15),
              // maxLines: 4,
              maxLength: 280,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.speaker_notes,color: Colors.red[300],),
                hintText: "What's happening?",
              ),
              onChanged: (text){
                story = text;
              },
            ),
            Container(
              margin: EdgeInsets.only(
                left: 10
              ),
              child:Row(
                children: <Widget>[
                  Icon(Icons.access_time,color:Colors.red[300]),
                  FlatButton(
                //tao
                // .########.####.##.....##.########.########.########.##.....##.########
                // ....##.....##..###...###.##..........##....##........##...##.....##...
                // ....##.....##..####.####.##..........##....##.........##.##......##...
                // ....##.....##..##.###.##.######......##....######......###.......##...
                // ....##.....##..##.....##.##..........##....##.........##.##......##...
                // ....##.....##..##.....##.##..........##....##........##...##.....##...
                // ....##....####.##.....##.########....##....########.##.....##....##...
                child: new Text(time,style: TextStyle(color: colorTime, fontSize: 15) ,),
                onPressed: ()async{
                  await selectTime(context);
                  time = _time.hour.toString()+" : "+_time.minute.toString();
                  setState(() {
                     if(colorTime == Colors.grey){
                      colorTime = Colors.red[400];
                     }
                  });
                  
                }
            ),          
                ],
              ),

              
            ),
            

            TextField(
              keyboardType: TextInputType.text,
              // textInputAction: TextInputAction.continueAction,
              textAlign: TextAlign.left,
              style: TextStyle(color: color, fontSize: 15),
              maxLength: 30,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.location_on,color: Colors.red[300],),
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
            // FlatButton(
            //   child: new Text('for test?',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600,fontSize: 20 )),
            //   onPressed: getSnapshot,
            // ),

          ],
        ),
          ),
          new Footer()
        ]
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _display,
          child: Icon(Icons.save)
      ),
    );
  }


}