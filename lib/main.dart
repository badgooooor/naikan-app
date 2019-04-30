import 'package:flutter/material.dart';
import 'Page/Page.dart';
import 'package:event_bus/event_bus.dart';
import 'Model/Model.dart';
import 'dart:async';

EventBus eventBus = EventBus();

  loadSave()async{
    // print(0);
    Api api = new Api();
    // print(1);
    Map<String,dynamic> l = await api.getPixelToday();
    if(l!={}){
      Map<String,String> pathImgFinalEmotino = {
        'happy':'Group35',
        'angry':'Group36',
        'love':'Group37',
        'passive':'Group38',
        'confuse':'Group39',
        'sad':'Group40'
      };
      Save.angry = l['angry'];
      Save.love = l['love'];
      Save.happy = l['happy'];
      Save.confused = l['confuse'];
      Save.sad = l['sad'];
      Save.passive = l['passive'];
      Save.finalEmotion = pathImgFinalEmotino[l['finalEmotion']];
    }
  }

void main(){
  print('starting the appppp');
  loadSave();
  runApp(LoginStateSet());
}


