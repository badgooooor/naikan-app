import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:async';

import 'Pixel.dart';

int year = DateTime.now().year;
int month = DateTime.now().month;
MonthPixel pixel = MonthPixel(year.toString(),month.toString());
int _count = 0;
bool _isChangeMonth=false;

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
  CalendarState createState(){

    return CalendarState();
  }
}

class CalendarState extends State<PixelCalendar> {
  /*if(_isChangeMonth){
    pixel = MonthPixel(year.toString(),month.toString());
  }*/

  Color _toColor(String value){
    switch(value){
      case 'angry':
        return new Color.fromARGB(255,255,58,58);
      case 'confuse':
        return new Color.fromARGB(255,221,120,251);
      case 'happy':
        return new Color.fromARGB(255,255,226,110);
      case 'love':
        return new Color.fromARGB(255,255,117,150);
      case 'passive':
        return new Color.fromARGB(255,104,232,142);
      case 'sad':
        return new Color.fromARGB(255,64,64,64);
      default:
        return new Color.fromARGB(255,128,128,128);
    }
  }

  Color pixelColor(int date){
    List pixelList = pixel.getMonthPixel(year,month);
    if(date>pixelList.length){
      return new Color.fromARGB(255,255,255,255);
    }
    return _toColor(pixelList[date-1]);
  }

  void _reload(){
    runApp(PixelCalendarSet());
    //print('###DEBUG###\npixel.getLoadingStatus() = '+pixel.getLoadingStatus().toString());
  }

  void _back(){
    print('ButtonDebugger: _back pressed');
  }

  void _lastMonth(){
    print('ButtonDebugger: _lastMonth pressed');
    //month++;
    _count=0;
    _isChangeMonth = true;
    _reload();
  }

  void _nextMonth(){
    print('ButtonDebugger: _nextMonth pressed');
    //month--;
    _count=0;
    _isChangeMonth = true;
    _reload();
  }

  @override
  Widget build(BuildContext context) {

    new Timer(const Duration(milliseconds: 2000),()async{
      if(pixel.getLoadingStatus()) {
        _reload();
      }
      else if(_count<1){
        _reload();
        _count++;
      }
      //print('###DEBUG###\n\t_count = $_count');
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
            CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.red),)
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
          //Calendar Box
          new Container(
            margin: EdgeInsets.fromLTRB(45,45,45,345),
            decoration: new BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              boxShadow: [BoxShadow(spreadRadius: 1.5,color: Colors.black12)],
            ),
          ),
          //Calendar Month Layer
          new Container(
            margin: EdgeInsets.fromLTRB(45,5,45,345),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(icon: Icon(Icons.chevron_left,color: Colors.white), onPressed: _lastMonth),
                Text('$year/$month',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                IconButton(icon: Icon(Icons.chevron_right,color: Colors.white), onPressed: _nextMonth),
              ],
            )
          ),
          //Calendar
          new Container(
            margin: EdgeInsets.fromLTRB(45,45,45,345),
            child: Table(
              defaultColumnWidth: FixedColumnWidth(38.5),
              children: [
                TableRow(
                  children: [
                    Icon(Icons.stop,color: pixelColor(1)),
                    Icon(Icons.stop,color: pixelColor(2)),
                    Icon(Icons.stop,color: pixelColor(3)),
                    Icon(Icons.stop,color: pixelColor(4)),
                    Icon(Icons.stop,color: pixelColor(5)),
                    Icon(Icons.stop,color: pixelColor(6)),
                    Icon(Icons.stop,color: pixelColor(7)),
                  ]
                ),
                TableRow(
                    children: [
                      Icon(Icons.stop,color: pixelColor(8)),
                      Icon(Icons.stop,color: pixelColor(9)),
                      Icon(Icons.stop,color: pixelColor(10)),
                      Icon(Icons.stop,color: pixelColor(11)),
                      Icon(Icons.stop,color: pixelColor(12)),
                      Icon(Icons.stop,color: pixelColor(13)),
                      Icon(Icons.stop,color: pixelColor(14)),
                    ]
                ),
                TableRow(
                    children: [
                      Icon(Icons.stop,color: pixelColor(15)),
                      Icon(Icons.stop,color: pixelColor(16)),
                      Icon(Icons.stop,color: pixelColor(17)),
                      Icon(Icons.stop,color: pixelColor(18)),
                      Icon(Icons.stop,color: pixelColor(19)),
                      Icon(Icons.stop,color: pixelColor(20)),
                      Icon(Icons.stop,color: pixelColor(21)),
                    ]
                ),
                TableRow(
                    children: [
                      Icon(Icons.stop,color: pixelColor(22)),
                      Icon(Icons.stop,color: pixelColor(23)),
                      Icon(Icons.stop,color: pixelColor(24)),
                      Icon(Icons.stop,color: pixelColor(25)),
                      Icon(Icons.stop,color: pixelColor(26)),
                      Icon(Icons.stop,color: pixelColor(27)),
                      Icon(Icons.stop,color: pixelColor(28)),
                    ]
                ),
                TableRow(
                    children: [
                      Icon(Icons.stop,color: pixelColor(29)),
                      Icon(Icons.stop,color: pixelColor(30)),
                      Icon(Icons.stop,color: pixelColor(31)),
                      Icon(Icons.stop,color: pixelColor(32)),
                      Icon(Icons.stop,color: pixelColor(33)),
                      Icon(Icons.stop,color: pixelColor(34)),
                      Icon(Icons.stop,color: pixelColor(35)),
                    ]
                ),
              ],
            )
            //Text('PIXEL CALENDAR',style: TextStyle(color: Color.fromARGB(255, 224, 61, 61)),)
          ),
          //Lower Decoration Box Background
          new Container(
            margin: EdgeInsets.only(top:450),
            decoration: new BoxDecoration(
              color: Colors.red,
            ),
          ),
          //AddButton Background
          new Container(
            margin: EdgeInsets.only(top:425,bottom: 25),
            foregroundDecoration: new BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle
            ),
          ),
          //AddButton
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
