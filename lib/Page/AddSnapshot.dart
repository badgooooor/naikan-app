import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AddSnapshot extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
        theme: ThemeData(

        ),
        home: HomePage(title: 'Add Snapshot')
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
  DateTime _date = new DateTime.now();
  TimeOfDay _time = new TimeOfDay.now();
  File image;
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
    print('name  = '+name);
    print('story = '+story);
    print('date =  ${_date.toString()}');
    print('time =  ${_time.toString()}');
    print('image=');
    print(image==null?null:image.path);
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
        title: Text(widget.title),
          backgroundColor: new Color(0xFFF34949),
          centerTitle: true,
      ),
      body: Center(
        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
                'SNAPSHOT',style: TextStyle(fontSize: 35,color: color)
            ),
            TextField(
              keyboardType: TextInputType.text,
              // textInputAction: TextInputAction.continueAction,
              textAlign: TextAlign.left,
              style: TextStyle(color: color, fontWeight: FontWeight.w800, fontSize: 20),
              maxLength: 30,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.accessibility_new),
                hintText: "Title",
              ),
              onChanged: (text){
                name = text;
              },
            ),
            TextField(
              keyboardType: TextInputType.text,
              // textInputAction: TextInputAction.continueAction,
              textAlign: TextAlign.left,
              style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 20),
              maxLines: 4,
              maxLength: 280,
              decoration: InputDecoration(
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
            FlatButton(
              child: new Text('Where?',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600,fontSize: 20 )),
              onPressed: null,
            ),
            FlatButton(
              child: new Text('Add photo?',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600,fontSize: 20 )),
              onPressed: selectImage,
            ),
            image!=null?new Image.file(image,width: 100,height: 100):new Text('select your image')
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