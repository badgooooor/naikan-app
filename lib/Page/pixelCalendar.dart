import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' as calendar;
import 'dart:async';

import 'Pixel.dart';

int year = DateTime.now().year;
int month = DateTime.now().month;

MonthPixel pixel = MonthPixel(year.toString(),month.toString());
DateTime _selectedDateTime = DateTime(year,month);
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
  CalendarState createState(){

    return CalendarState();
  }
}

class CalendarState extends State<PixelCalendar> {
  IconData pixelIcon = Icons.brightness_1;

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
    int _date = date-DateTime(year,month,1).weekday;

    if(_date<=pixelList.length&&_date>0) return _toColor(pixelList[_date-1]);
    else return new Color.fromARGB(0,0,0,0);
  }

  void _reload(){
    runApp(PixelCalendarSet());
    //print('###DEBUG###\npixel.getLoadingStatus() = '+pixel.getLoadingStatus().toString());
  }

  void _changeMonth(int _year,int _month){
     year=_year;
    month=_month;
    pixel = MonthPixel(_year.toString(),_month.toString());
    _selectedDateTime = DateTime(_year,_month);
    _count=0;
    print('Changing to $_year/$_month');

    _reload();
  }

  void _back(){
    print('ButtonDebugger: _back pressed');
  }

  void _lastMonth(){
    print('ButtonDebugger: _lastMonth pressed');
    _count=0;
    if(month-1==0) _changeMonth(year-1, 12);
    else _changeMonth(year, month-1);
  }

  void _nextMonth(){
    print('ButtonDebugger: _nextMonth pressed');
    _count=0;
    if(month+1==13) _changeMonth(year+1, 1);
    else _changeMonth(year, month+1);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double pixelSize=height*2/75;

    new Timer(const Duration(milliseconds: 2000),()async{
      if(pixel.getLoadingStatus()) {
        _reload();
      }
      else if(_count<1){
        _reload();
        _count++;
      }
    });
    final List<charts.Series<LinearData, int>> seriesList = pixel.toChart();
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: new IconButton(
          icon:Icon(Icons.chevron_left,size:30),
          onPressed: _back
        ),
        title: Text('PIXEL CALENDAR',style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
      ),
      body: new Stack(
        children: <Widget>[
          //Pie Chart
          new Padding(
            padding: EdgeInsets.only(top: height/2,right: width*3/5,bottom: height/6),
            child: pixel.getLoadingStatus()
                ?Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.red),)
                    ],
                  )
                )
                :new charts.PieChart(
                  seriesList,
                  animate: false,
                  defaultRenderer: new charts.ArcRendererConfig(
                      arcWidth: width~/24,
                  )
                ),
          ),
          //Chart Label <jpg>
          new Padding(
            padding: EdgeInsets.only(left: width*2/5,top: height/2,right: width/16,bottom: height/6),
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
            margin: EdgeInsets.only(bottom: height*14/32),
            decoration: new BoxDecoration(
              color: Colors.red,
            ),
          ),
          //Calendar Box
          new Container(
            margin: EdgeInsets.only(left:45,top:75,right:45,bottom:height*15/32),
            decoration: new BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              boxShadow: [BoxShadow(spreadRadius: 1.5,color: Colors.black12)],
            ),
          ),
          //Button
          new Container(
            margin: EdgeInsets.only(left:45,top:30,right:45),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(icon: Icon(Icons.chevron_left,color: Colors.white,size: 30,), onPressed: _lastMonth),
                Padding(padding: EdgeInsets.only(left:80,right:80)),
                IconButton(icon: Icon(Icons.chevron_right,color: Colors.white,size: 30,), onPressed: _nextMonth),
              ],
            ),
          ),
          //DayColor
          new Container(
              margin: EdgeInsets.only(left:45,top:102,right:45,bottom:290),
              child: Table(
                defaultColumnWidth: FixedColumnWidth((width-90)/7),
                children: [
                  TableRow(
                      children: [
                        Icon(pixelIcon,color: pixelColor(1),size: pixelSize),
                        Icon(pixelIcon,color: pixelColor(2),size: pixelSize),
                        Icon(pixelIcon,color: pixelColor(3),size: pixelSize),
                        Icon(pixelIcon,color: pixelColor(4),size: pixelSize),
                        Icon(pixelIcon,color: pixelColor(5),size: pixelSize),
                        Icon(pixelIcon,color: pixelColor(6),size: pixelSize),
                        Icon(pixelIcon,color: pixelColor(7),size: pixelSize),
                      ]
                  ),
                  TableRow(
                      children: [
                        Icon(pixelIcon,color: pixelColor(8),size: pixelSize),
                        Icon(pixelIcon,color: pixelColor(9),size: pixelSize),
                        Icon(pixelIcon,color: pixelColor(10),size: pixelSize),
                        Icon(pixelIcon,color: pixelColor(11),size: pixelSize),
                        Icon(pixelIcon,color: pixelColor(12),size: pixelSize),
                        Icon(pixelIcon,color: pixelColor(13),size: pixelSize),
                        Icon(pixelIcon,color: pixelColor(14),size: pixelSize),
                      ]
                  ),
                  TableRow(
                      children: [
                        Icon(pixelIcon,color: pixelColor(15),size: pixelSize),
                        Icon(pixelIcon,color: pixelColor(16),size: pixelSize),
                        Icon(pixelIcon,color: pixelColor(17),size: pixelSize),
                        Icon(pixelIcon,color: pixelColor(18),size: pixelSize),
                        Icon(pixelIcon,color: pixelColor(19),size: pixelSize),
                        Icon(pixelIcon,color: pixelColor(20),size: pixelSize),
                        Icon(pixelIcon,color: pixelColor(21),size: pixelSize),
                      ]
                  ),
                  TableRow(
                      children: [
                        Icon(pixelIcon,color: pixelColor(22),size: pixelSize),
                        Icon(pixelIcon,color: pixelColor(23),size: pixelSize),
                        Icon(pixelIcon,color: pixelColor(24),size: pixelSize),
                        Icon(pixelIcon,color: pixelColor(25),size: pixelSize),
                        Icon(pixelIcon,color: pixelColor(26),size: pixelSize),
                        Icon(pixelIcon,color: pixelColor(27),size: pixelSize),
                        Icon(pixelIcon,color: pixelColor(28),size: pixelSize),
                      ]
                  ),
                  TableRow(
                      children: [
                        Icon(pixelIcon,color: pixelColor(29),size: pixelSize),
                        Icon(pixelIcon,color: pixelColor(30),size: pixelSize),
                        Icon(pixelIcon,color: pixelColor(31),size: pixelSize),
                        Icon(pixelIcon,color: pixelColor(32),size: pixelSize),
                        Icon(pixelIcon,color: pixelColor(33),size: pixelSize),
                        Icon(pixelIcon,color: pixelColor(34),size: pixelSize),
                        Icon(pixelIcon,color: pixelColor(35),size: pixelSize),
                      ]
                  ),
                  TableRow(
                      children: [
                        Icon(pixelIcon,color: pixelColor(36),size: pixelSize),
                        Icon(pixelIcon,color: pixelColor(37),size: pixelSize),
                        Icon(pixelIcon,color: pixelColor(38),size: pixelSize),
                        Icon(pixelIcon,color: pixelColor(39),size: pixelSize),
                        Icon(pixelIcon,color: pixelColor(40),size: pixelSize),
                        Icon(pixelIcon,color: pixelColor(41),size: pixelSize),
                        Icon(pixelIcon,color: pixelColor(42),size: pixelSize),
                      ]
                  ),
                ],
              )
          ),
          //Calendar
          new Container(
            margin: EdgeInsets.only(left:45,top:24,right:45),
            child: calendar.CalendarCarousel(
              childAspectRatio: 2,
              weekdayTextStyle: TextStyle(fontFamily: 'Leelawadee'),
              daysTextStyle: TextStyle(fontFamily: 'Leelawadee',color: Colors.white),
              weekendTextStyle: TextStyle(fontFamily: 'Leelawadee',color: Colors.white),
              todayTextStyle: TextStyle(fontFamily: 'Leelawadee',color: Colors.redAccent),
              headerTextStyle: TextStyle(
                color: Colors.white,
                fontFamily: 'Leelawadee',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              selectedDateTime: _selectedDateTime,
              todayButtonColor: Color.fromARGB(0, 0, 0, 0),
              selectedDayButtonColor: Color.fromARGB(0, 0, 0, 0),
              showHeaderButton: false,
            )
            //Text('PIXEL CALENDAR',style: TextStyle(color: Color.fromARGB(255, 224, 61, 61)),)
          ),
          //Lower Decoration Box Background
          new Container(
            margin: EdgeInsets.only(top:height*25/32),
            decoration: new BoxDecoration(
              color: Colors.red,
            ),
          ),
          //AddButton Background
          new Container(
            margin: EdgeInsets.only(top:height*47/64,bottom: height*5/64),
            foregroundDecoration: new BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle
            ),
          ),
          //AddButton
          new Container(
            padding: EdgeInsets.only(top:height*24/32,left:width*5/12,right:width*5/12),
            child: RaisedButton(
                shape: CircleBorder(),
                color: Colors.redAccent,
                onPressed: () =>print('ButtonDebugger: add pressed'),
              child: Icon(Icons.add,size: 30),
            ),
          ),
          //Button Row
          new Center(
            child: new Padding(
              padding: EdgeInsets.only(top:height*0.775),
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
                      margin: EdgeInsets.only(left:width/25,right:width/7),
                      child:new IconButton(
                        icon:Icon(Icons.edit,color:Colors.white30,size:30),
                        onPressed: () => print('ButtonDebugger: addsnap pressed'),
                      )
                  ),
                  Container(
                      margin: EdgeInsets.only(left:width/7,right:width/25),
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
