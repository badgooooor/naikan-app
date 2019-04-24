import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:async';

import 'Pixel.dart';

String year='2019';
String month='4';
MonthPixel pixel = MonthPixel(year,month);
int _count = 0;

class PixelCalendarSet extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Naikan',
      theme: ThemeData(
        primarySwatch: Colors.red,
          fontFamily: 'Leelawadee'
      ),
      home: PixelCalendar(title: 'Naikan_PixelCalendar'),
    );
  }
}

class PixelCalendar extends StatefulWidget {
  PixelCalendar({Key key, this.title}) : super(key: key);

  final String title;

  @override
  CalendarState createState() => CalendarState();
}

class WaitingState extends State<PixelCalendar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Text('LOADING...')
        ],
      ),
    );
  }
}

class CalendarState extends State<PixelCalendar> {
  

  void _getEmotion() {
    print(pixel.getEmotionSummary());
  }
  
  void _reload(){
    runApp(PixelCalendarSet());
    print('###DEBUG###\npixel.getLoadingStatus() = '+pixel.getLoadingStatus().toString());
  }
  
  Future _wait(int milliseconds)async{
    return await(Duration(milliseconds: milliseconds));
  }

  void _back(){
    print('ButtonDebugger: _back pressed');
  }

  @override
  Widget build(BuildContext context) {
    Timer _timer = new Timer(const Duration(milliseconds: 2000),()async{
      _wait(200);
      if(pixel.getLoadingStatus()) {
        _reload();
      }
      else if(_count<1){
        _reload();
        _count++;
      }
      print('###DEBUG###\n\t_count = $_count');
    });
    final List<charts.Series<LinearData, int>> seriesList = pixel.toChart();
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: new IconButton(
          icon:Icon(Icons.chevron_left,size:30),
          onPressed: _back
        ),
        title: Text('PIXEL CALENDAR',style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: pixel.getLoadingStatus()
      ?Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('LOADING...'),
            /*Text('Something went wrong ;('),
            RaisedButton(
              onPressed: _reload,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
              ),
              child: Text('Reload')
            ),*/

          ],
        )
      )

          :new Stack(
        children: <Widget>[
          //Pie Chart
          new Padding(
              padding: EdgeInsets.fromLTRB(0, 200, 200, 40),
            child: new charts.PieChart(
                seriesList,
                animate: false,
                defaultRenderer: new charts.ArcRendererConfig(
                    arcWidth: 20,
                    //arcRendererDecorators: [new charts.ArcLabelDecorator()]
                )
            ),
          ),
          //Chart Label <jpg>
          new Padding(
            padding: EdgeInsets.fromLTRB(160, 200, 20, 50),
            child: new Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                    image: AssetImage('assets/PixelCalendar_label.jpg'),
                    fit: BoxFit.scaleDown
                ),
              ),
            ),
          ),
          //Upper Decoration Box Background
          new Container(
            margin: EdgeInsets.only(bottom: 300),
            decoration: new BoxDecoration(
              color: Colors.red,
            ),
          ),
          new Container(
            margin: EdgeInsets.fromLTRB(45,45,45,345),
            decoration: new BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              boxShadow: [BoxShadow(spreadRadius: 1.5,color: Colors.black12)],
            ),
          ),
          new Container(
            margin: EdgeInsets.fromLTRB(125,98,0,0),
            child: Text('PIXEL CALENDAR',style: TextStyle(color: Color.fromARGB(255, 224, 61, 61)),)
          ),
          //Lower Decoration Box Background
          new Container(
            margin: EdgeInsets.only(top:450),
            decoration: new BoxDecoration(
              color: Colors.red,
            ),
          ),
          

          new Container(
            margin: EdgeInsets.only(top:425,bottom: 25),
            foregroundDecoration: new BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle
            ),
          ),
          new Container(
            margin: EdgeInsets.only(top:431,left:135.5),
            child: RaisedButton(
                shape: CircleBorder(),
                color: Colors.redAccent,
                onPressed: () =>print('ButtonDebugger: add pressed'),
              child: Icon(Icons.add,size: 30),
            ),
          ),
          
          new Center(
            child: new Padding(
              padding: EdgeInsets.fromLTRB(0, 450, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(),
                      child:new IconButton(
                        icon:Icon(Icons.home,color:Colors.white30,size:30),
                        onPressed: () => print('ButtonDebugger: home pressed'),
                      )
                  ),
                  Container(
                      margin: EdgeInsets.only(left:20,right:50),
                      child:new IconButton(
                        icon:Icon(Icons.edit,color:Colors.white30,size:30),
                        onPressed: () => print('ButtonDebugger: addsnap pressed'),
                      )
                  ),
                  Container(
                      margin: EdgeInsets.only(left:50,right:20),
                      child:new IconButton(
                        icon:Icon(Icons.favorite,color:Colors.white30,size:30),
                        onPressed: () => print('ButtonDebugger: favourite pressed'),
                      )
                  ),
                  Container(
                      margin: EdgeInsets.only(),
                      child:new IconButton(
                        icon:Icon(Icons.settings,color:Colors.white30,size:30),
                        onPressed: () => print('ButtonDebugger: setting pressed'),
                      )
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}