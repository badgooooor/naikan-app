// import 'package:flutter/material.dart';


class Save{
  static int dateTime = DateTime.now().year*10000+DateTime.now().month*100+DateTime.now().day;

  static Map<int,int> happy = {dateTime:0};
  static Map<int,int> angry = {dateTime:0};
  static Map<int,int> love = {dateTime:0};
  static Map<int,int> passive = {dateTime:0};
  static Map<int,int> confused = {dateTime:0};
  static Map<int,int> sad = {dateTime:0};
  static Map<int,String> finalEmotion = {dateTime:'Group 36'};

  static int getHappy(int dateTime){
    return happy[dateTime];
  }

  static int getAngry(int dateTime){
    return angry[dateTime];
  }
  static int getLove(int dateTime){
    return love[dateTime];
  }
  static int getPassive(int dateTime){
    return passive[dateTime];
  }
  static int getConfused(int dateTime){
    return confused[dateTime];
  }
  static int getSad(int dateTime){
    return sad[dateTime];
  }

  static String getFinalEmotion(int dateTime){
    return finalEmotion[dateTime];
  }

  static void setHappy(int dateTime,int value){
    if(happy.containsKey(dateTime)) happy[dateTime]=value;
    else happy.addAll({dateTime:(value==null?0:value)});
  }

  static void setAngry(int dateTime,int value){
    if(angry.containsKey(dateTime)) angry[dateTime]=value;
    else angry.addAll({dateTime:(value==null?0:value)});
  }

  static void setPassive(int dateTime,int value){
    if(passive.containsKey(dateTime)) passive[dateTime]=value;
    else passive.addAll({dateTime:(value==null?0:value)});
  }

  static void setConfused(int dateTime,int value){
    if(confused.containsKey(dateTime)) confused[dateTime]=value;
    else confused.addAll({dateTime:(value==null?0:value)});
  }

  static void setLove(int dateTime,int value){
    if(love.containsKey(dateTime)) love[dateTime]=value;
    else love.addAll({dateTime:(value==null?0:value)});
  }

  static void setSad(int dateTime,int value){
    if(sad.containsKey(dateTime)) sad[dateTime]=value;
    else sad.addAll({dateTime:(value==null?0:value)});
  }

  static void setFinalEmotion(int dateTime,String value){
    if(finalEmotion.containsKey(dateTime)) finalEmotion[dateTime]=value;
    else finalEmotion.addAll({dateTime:(value==null?'Group 36':value)});
  }

  static bool isDayEmpty(DateTime date){
    int dateTime = date.year*10000+date.month*100+date.day;

    if(happy[dateTime]!=0
        &&angry[dateTime]!=0
        &&passive[dateTime]!=0
        &&sad[dateTime]!=0
        &&love[dateTime]!=0
        &&confused[dateTime]!=0
    ) return false;
    return true;
  }

  static void debug(){
    print('###DEBUG###\n\t\thappy = $happy\n\t\tangry = $angry\n\t\tpassive = $passive\n\t\tconfused = $confused\n\t\tsad = $sad\n\t\tlove = $love');
  }

}

