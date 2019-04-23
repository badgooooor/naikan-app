import 'package:flutter/material.dart';
import 'package:event_bus/event_bus.dart';
EventBus eventBus = EventBus();
void main(){
  // const PrimaryColor = const Color(0xF34949);
  runApp(MaterialApp(
    title: 'test',
    home: Body(),
    
    // theme: ThemeData(
    //   primaryColor: PrimaryColor,
    // ),
 
  ));
}

class Body extends StatelessWidget{
  //static const PrimaryColor = const Color(0xFFFFFF100);
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: new Color(0xFFF34343),
      appBar: AppBar(
        leading: Icon(Icons.chevron_left,size:30,),
        actions: <Widget>[
          Container( 
            margin: EdgeInsets.only(
              right: 16,
            
            ),
            child: Icon(Icons.search,size:30)),
          
        ],
        backgroundColor: new Color(0xFFF34343),
        
       // backgroundColor: PrimaryColor,
        centerTitle: true ,
        title: Text('SNAPSHOT'),
        
      ),
      body: Viewsnap(),
      bottomNavigationBar: Footer(),
    );
  }

}
class Footer extends StatefulWidget{
@override
FooterState createState(){
  return new FooterState();
}

}

class FooterState extends State<Footer>{
  @override
  Widget build(BuildContext context){
    return Container(
      
      width: 370,
      height: 51,
      color: new Color(0xFFF34949),
      child: new Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              left: 57
            ),
            child:
            Icon(Icons.home,color: Colors.white30,size: 30,)
          ),
          Container(
            margin: EdgeInsets.only(
              left: 57
            ),
            child:
            Icon(Icons.edit,color: Colors.white30,size: 30)
          ),
          Container(
            margin: EdgeInsets.only(
              left: 57
            ),
            child:
            Icon(Icons.favorite,color: Colors.white30,size: 30)
            ),
          Container(
            margin: EdgeInsets.only(
              left: 57
            ),
            child:
            Icon(Icons.settings,color: Colors.white30,size: 30)
          ),
          
        
        ],
      ),
    );
  }
}
class BodyContent extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('tao'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Viewsnap(),

            ],
          ),
        ],
      ),
    );
  }

}
class Viewsnap extends StatefulWidget{

  @override
  ViewsnapState createState() {
      return new ViewsnapState();
    }
}

class ViewsnapState extends State<Viewsnap>{
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      
      itemCount: 10,
      itemBuilder: (BuildContext context, int index){
        return new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Content()
          ],
        );
      },
    );
  }
}

class Content extends StatefulWidget{
@override
ContentState createState() {
      return new ContentState();
    }

}
class ContentState extends State<Content>{
  @override
  Widget build(BuildContext context){
    return Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      width: 334,
      height: 157,
      margin: EdgeInsets.all(4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: 80.0 ),
            decoration: new BoxDecoration(
              color: new Color(0xFFF9A9A9),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0)

              ),
            ),
            width: 334,
            height: 26,
            child: new Row(
              children: <Widget>[
                
                Text('TODAY 23 APRILL'),
            
              ],
            ),
           
          ),
          Container(

            width: 334,
            height: 94,
            color: Colors.white,
            child: new,
           
          ),
          new Divider(
            height: 0,
            color: Colors.grey,
            
          ),
          Container(
            padding: EdgeInsets.only(
              left: 20,
              top: 10
            ),
            child: new Row(
              children: <Widget>[
                Text('View detail')
              ],
            ),
          ),
        ],
      ),
      


    );
  }

}
