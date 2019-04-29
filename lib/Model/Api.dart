import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as client;


class Api{
  Future<client.Response>postPixel(Map data) async {
    String urlPost = 'https://us-central1-naikan-87838.cloudfunctions.net/webApi/api/v1/pixels/todayPixel';
    String pixelText = json.encode(data);
    print('postPixel');
    print(pixelText);

    return client.post(
        urlPost,
        headers: {"Content-Type" : "application/json"},
        body: pixelText)
        .then((client.Response response){
      final int statusCode = response.statusCode;
      print('statusCode \t=\t'+statusCode.toString());
    });
  }
  Future<client.Response>postEditPixel(Map data) async {
    String urlPost = 'https://us-central1-naikan-87838.cloudfunctions.net/webApi/api/v1/pixels/pastPixel';
    String pixelText = json.encode(data);
    print('postEditPixel');
    print(pixelText);

    return client.post(
        urlPost,
        headers: {"Content-Type" : "application/json"},
        body: pixelText)
        .then((client.Response response){
      final int statusCode = response.statusCode;
      print('statusCode \t=\t'+statusCode.toString());
    });
  }
  Future<client.Response>postSnapshot(Map data) async{
    String urlPost = 'https://us-central1-naikan-87838.cloudfunctions.net/webApi/api/v1/snapshots/addSnapshot';
    String snapshotText = json.encode(data);
    print('postSnapshot');
    print(snapshotText);

    return client.post(
        urlPost,
        headers: {"Content-Type" : "application/json"},
        body: snapshotText)
        .then((client.Response response){
      final int statusCode = response.statusCode;
      print('statusCode \t=\t'+statusCode.toString());
    });
  }

  // Future<client.Response>getSnapshotDate(int date) async{
  //   String urlGetDate = 'https://us-central1-naikan-87838.cloudfunctions.net/webApi/api/v1/snapshots/Snapshot/'+date.toString();
  //   print('getSnapshot from Date');
  //   print('url = '+ urlGetDate);
  //   client.Response response = await client.get(urlGetDate,headers:{"Content-Type" : "application/json"} );
  //   return response;
  // }
  Future<Snapshot>getSnapshotDate(int date) async{
    String urlGetDate = 'https://us-central1-naikan-87838.cloudfunctions.net/webApi/api/v1/snapshots/Snapshot/'+date.toString();
    print('getSnapshot from Date');
    print('url = '+ urlGetDate);
    client.Response response = await client.get(urlGetDate,headers:{"Content-Type" : "application/json"} );
    Snapshot snapshot = Snapshot.fromJson(json.decode(response.body));
    return snapshot;
  }
  Future<List<Snapshot>> getSnapshotAll() async{
    String urlGetAll = 'https://us-central1-naikan-87838.cloudfunctions.net/webApi/api/v1/snapshots/getAll';
    client.Response response = await client.get(urlGetAll,headers: {"Content-Type" : "application/json"});
    // print(response.body);
    // print(json.decode(response.body)['snapshots']);
    Map<String,dynamic> l = json.decode(response.body)['snapshots'];
    List<Snapshot> allSnapshot = new List();
    // print(l);
    l.forEach((k,v){
      var snap = Snapshot.fromJson(v);
      allSnapshot.add(snap);
    });
  
    // print(allSnapshot);
  return allSnapshot;
  }

  Future<List<Snapshot>> getSnapshotYearMonth(int year,int month) async{
    String urlGetYearMonth = 'https://us-central1-naikan-87838.cloudfunctions.net/webApi/api/v1/snapshots/monthSnapshot/$year/$month';
    // print(urlGetYearMonth);
    client.Response response = await client.get(urlGetYearMonth,headers: {"Content-Type" : "application/json"});
    List<Snapshot> allSnapshot = new List();
    if(response.body!='No such document!'){
    // print(json.decode(response.body));
    Map<String,dynamic> l = json.decode(response.body);
    // print(l);
    l.forEach((k,v){
      var snap = Snapshot.fromJson(v);
      allSnapshot.add(snap);
    });
    }
    else{
      DateTime _date = new DateTime.now();
       int dateInt = _date.year*10000+_date.month*100+_date.day;
      allSnapshot.add(new Snapshot(
        title: 'No Snapshot here :)'
        ,time: 'Better late than never'
        ,place: 'Utopia'
        ,detail: 'Please add Snapshot when you feel it :D'
        ,date: 0 ));
    }
    print(allSnapshot);
    return allSnapshot;
  }


}

class Snapshot{
  final String title,detail,time,place;
  final int date;

  Snapshot({this.date,this.detail,this.place,this.time,this.title});
  
  factory Snapshot.fromJson(Map<String,dynamic> json){
    return Snapshot(
        title: json['title'],
        detail: json['detail'],
        time: json['time'],
        place: json['place'],
        date: json['date']
    );
  }
  @override
  String toString() {
    return 
    '[\n' + 'date \t:\t' + this.date.toString() + '\n' +
     'title\t:\t' + this.title + '\n' +
     'detail\t:\t' + this.detail + '\n' +
     'time \t:\t' + this.time + '\n' +
     'place\t:\t' + this.place + '\n' + ']';
  }
}