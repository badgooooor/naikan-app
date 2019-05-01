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
    int dateTime = DateTime.now().year*10000+DateTime.now().month*100+DateTime.now().day;
    Map<String,String> pathImgFinalEmotino = {
      'happy':'Group35',
      'angry':'Group36',
      'love':'Group37',
      'passive':'Group38',
      'confuse':'Group39',
      'sad':'Group40'
    };
    Save.setAngry(dateTime,l['angry']);
    Save.setLove(dateTime,l['love']);
    Save.setHappy(dateTime,l['happy']);
    Save.setConfused(dateTime,l['confuse']);
    Save.setSad(dateTime,l['sad']);
    Save.setPassive(dateTime,l['passive']);
    Save.setFinalEmotion(dateTime,pathImgFinalEmotino[l['finalEmotion']]);
  }
}

loadPastSave(DateTime date)async{
  // print(0);
  Api api = new Api();
  // print(1);
  Map<String,dynamic> l = await api.getPixelDay(date);
  if(l!={}){
    print(l);
    int dateTime = date.year*10000+date.month*100+date.day;
    Map<String,String> pathImgFinalEmotino = {
      'happy':'Group35',
      'angry':'Group36',
      'love':'Group37',
      'passive':'Group38',
      'confuse':'Group39',
      'sad':'Group40'
    };

    Save.setAngry(dateTime,l['angry']);
    Save.setLove(dateTime,l['love']);
    Save.setHappy(dateTime,l['happy']);
    Save.setConfused(dateTime,l['confuse']);
    Save.setSad(dateTime,l['sad']);
    Save.setPassive(dateTime,l['passive']);
    Save.setFinalEmotion(dateTime,pathImgFinalEmotino[l['finalEmotion']]);



  }
}

void main(){
  print('starting the appppp');
  loadSave();
  runApp(LoginStateSet());
}


