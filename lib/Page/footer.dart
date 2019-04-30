import 'package:flutter/material.dart';
import 'Page.dart';

class Footer extends StatefulWidget{
  @override
  FooterState createState(){
    return new FooterState();
  }
}

class FooterState extends State<Footer>{
  
  @override
  Widget build(BuildContext context){
    double width = MediaQuery.of(context).size.width;
    
    return new Stack(
      children: <Widget>[
        //BottomBar
          new Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children:<Widget>[
                  new Container(
                    height: 54,
                    color: Colors.red,
                    child: new Row(
                      children: <Widget>[
                        //home
                        Container(
                            margin: EdgeInsets.only(
                                left: 32.5
                            ),
                            child:
                            new IconButton(
                              icon: Icon(Icons.edit,color: Colors.white70,size: 30,),
                              onPressed: (){
                                print('home');
                                
                                Navigator.push(context,
                                MaterialPageRoute(builder: (context)=> AddSnapshot()));
                              },
                            )

                        ),
                        //addSnap
                        Container(
                            margin: EdgeInsets.only(
                                left: 32.5
                            ),
                            child:
                            new IconButton(
                              icon :Icon(Icons.favorite,color: Colors.white70,size: 30),
                              onPressed: (){
                                print('addsnap');
                                Navigator.push(context,
                                MaterialPageRoute(builder: (context)=> ViewSnapPage()));
                                
                              },
                            )

                        ),
                        //snap
                        Container(
                            margin: EdgeInsets.only(
                                left: 95
                            ),
                            child:
                            new IconButton(
                              icon: Icon(Icons.view_comfy,color: Colors.white70,size: 30),
                              onPressed: (){
                                print('snap');
                                CalendarState().reload();
                                Navigator.push(context,
                                MaterialPageRoute(builder: (context)=> new PixelCalendar()));
                              },
                            )
                          //overView
                        ),
                        //overview
                        Container(
                            margin: EdgeInsets.only(
                                left: 32.5
                            ),
                            child:
                            new IconButton(
                              icon:Icon(Icons.settings,color: Colors.white70,size: 30),
                              onPressed: (){
                                print('setting');
                               
                              },
                            )
                        ),
                      ],
                    ),
                  ),
            ]
          ),
          //AddButtonBackground
          new Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children:<Widget>[
                new Container(
                  margin: EdgeInsets.only(left:(width-72)/2,bottom:18),
                  width: 72,
                  height: 72,
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle
                  ),
                ),
              ]
          ),
          //AddButton
          new Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children:<Widget>[
                new Container(
                  padding: EdgeInsets.only(left:(width-62)/2,right:(width-62)/2,bottom:28),
                  child: ButtonTheme(
                    height: 54,
                    minWidth: 54,
                    child: new RaisedButton(
                      shape: CircleBorder(),
                      color: Colors.redAccent,
                      onPressed: () {
                        print('ButtonDebugger: add pressed');
                        AddPixel().setDate(new DateTime.now());
                        Navigator.popUntil(context, ModalRoute.withName('/'));
                        },
                      child: Icon(Icons.add,size: 30),
                    ),
                  )
                ),
              ]
          ),


      ],
    );
  }
}
