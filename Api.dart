import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as client;
import 'dart:io';


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
}