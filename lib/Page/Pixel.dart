import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:convert';

class Pixel{
  Map<String,dynamic> data;
  http.Response resp;
  static bool isLoading;

  Pixel(){
    isLoading=true;
  }

  bool getLoadingStatus(){
    return isLoading;
  }

  void setLoadingStatus(bool status){
    isLoading=status;
  }

  Map<String,dynamic> getEmotionSummary() {
    int _angry = 0;
    int _confuse = 0;
    int _happy = 0;
    int _love = 0;
    int _passive = 0;
    int _sad = 0;
    Map<String, dynamic> emotionSummary;

    if (data != null) {
      //print('###DEBUG###\n\t\tdata.length = $data.length.toString()');
    for (int i = 0; i < data.length; i++) {
      switch (data.values.elementAt(i)['finalEmotion']) {
        case 'angry':
          {
            _angry++;
            break;
          }
        case 'confuse':
          {
            _confuse++;
            break;
          }
        case 'happy':
          {
            _happy++;
            break;
          }
        case 'love':
          {
            _love++;
            break;
          }
        case 'passive':
          {
            _passive++;
            break;
          }
        case 'sad':
          {
            _sad++;
            break;
          }
      }
    }

    emotionSummary = {
      'angry': _angry,
      'confuse': _confuse,
      'happy': _happy,
      'love': _love,
      'passive': _passive,
      'sad': _sad
    };

    return emotionSummary;
  }
    return null;

  }

  static List<charts.Series<LinearData, int>> _toChart(Map<String,dynamic> data){
    List<LinearData> dataList = [];

    if (data != null) {
      for (int i = 0; i < data.length; i++) {
        dataList.add(new LinearData(i, data.values.elementAt(i).toInt(), null));
        dataList[i].setColor(i);
        print(dataList[i].toList().toString());
      }

      return [
        new charts.Series<LinearData, int>(
          id: 'Pixel_Chart',
          domainFn: (LinearData cell, _) => cell.getDomain(),
          measureFn: (LinearData cell, _) => cell.getMeasure(),
          colorFn: (LinearData cell, _) => cell.getColor(),
          data: dataList,
        )
      ];
    }
    return null;
  }

  List<charts.Series<LinearData, int>> toChart(){
    return _toChart(getEmotionSummary());
  }

}

class MonthPixel extends Pixel{

  MonthPixel(String year,String month){
    loadMonthPixel(year, month);
  }

  Future loadMonthPixel(String year,String month) async{
    resp= await http.get("https://us-central1-naikan-87838.cloudfunctions.net/webApi/api/v1/pixels/monthPixel/$year/$month");
    if(resp.body=='No such document!') {
      data=null;
    }
    else {
      data = json.decode(resp.body);
    }
    //print('###DEBUG###\n\tloadMonthPixel.data = $data');
    setLoadingStatus(false);
    return resp;
  }

  List getMonthPixel(year,month){
    int days;
    List pixelList=[];

    if(data != null){
      if(month==1||month==3||month==5||month==7||month==8||month==10||month==12){
        days=31;
      }
      else if(month==4||month==6||month==9||month==11) days=31;
      else if(month==2) {
        if (year % 4 == 0) days=29;
        else days=28;
      }
      //print('###DEBUG###\n\t\tdata = $data,\n\t\tmonth = $month, days = $days');
      for(int i=1;i<=days;i++){

        //String date=(i<10?('0'+i.toString()):i.toString());
        String value='NULL';
        for(int j=0;j<data.length;j++){
          int date=data.values.elementAt(j)['date']%100;
          if(i==date) value=data.values.elementAt(j)['finalEmotion'];
          //print('###DEBUG###\n\t\ti = $i, date = $date,j = $j, value = $value');
        }
        pixelList.add(value);
        //print('###DEBUG###\n\t\tpixelList = $pixelList');
      }
    }
    return pixelList;
  }
}

class LinearData {
  final int domain;
  final int measure;
  charts.Color color;

  LinearData(this.domain, this.measure, this.color);

  int getDomain(){
    return domain;
  }
  int getMeasure(){
    return measure;
  }
  charts.Color getColor(){
    return this.color;
  }

  List toList(){
    return [domain,measure,color];
  }

  String domainName(int domain){
    switch(domain){
      case 0:
        return 'angry';
      case 1:
        return 'confuse';
      case 2:
        return 'happy';
      case 3:
        return 'love';
      case 4:
        return 'passive';
      case 5:
        return 'sad';
      default:
        return null;
    }
  }

  charts.Color _domainColor(int domain){
    switch(domain){
      case 0:
        return new charts.Color(r: 255, g: 58, b: 58, a: 255);
      case 1:
        return new charts.Color(r: 221, g: 120, b: 251, a: 255);
      case 2:
        return new charts.Color(r: 255, g: 226, b: 110, a: 255);
      case 3:
        return new charts.Color(r: 255, g: 117, b: 150, a: 255);
      case 4:
        return new charts.Color(r: 104, g: 232, b: 142, a: 255);
      case 5:
        return new charts.Color(r: 64, g: 64, b: 64, a: 255);
      default:
        return null;
    }
  }

  void setColor(int domain){
    color = _domainColor(domain);
  }
}