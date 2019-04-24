import 'package:flutter/material.dart';
import 'package:event_bus/event_bus.dart';
import 'Page/Pages.dart';
EventBus eventBus = EventBus();
void main(){
  const PrimaryColor = const Color(0xF34949);
  runApp(MaterialApp(
    title: 'test',
    home: Body(),
    
    // theme: ThemeData(
    //   primaryColor: PrimaryColor,
    // ),
 
  ));
//runApp(ExpansionTileSample());
  
}

