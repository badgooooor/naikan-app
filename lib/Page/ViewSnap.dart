import 'package:flutter/material.dart';
import 'package:event_bus/event_bus.dart';
import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';
class ViewSnapPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: "ViewSnap",
      home: Body(),
    );
  }
  
}
class Body extends StatelessWidget{
  //static const PrimaryColor = const Color(0xFFFFFF100);
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: new Color(0xFFF34343),
      appBar: AppBar(

        leading: new IconButton(
          icon : Icon(Icons.chevron_left,size:30,),
          onPressed: (){
            print('backk');
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search,size:30),
            onPressed: (){
              print('searchhh');
            },
          )
          // Container( 
          //   margin: EdgeInsets.only(
          //     right: 16,
            
          //   ),
            
          //   child: new IconButton(
              
          //   )
              
          //   ),
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
              left: 45
            ),
            child:
            new IconButton(
              icon: Icon(Icons.home,color: Colors.white30,size: 30,),
              onPressed: (){
                print('home');
              },
            )
            
          ),
          Container(
            margin: EdgeInsets.only(
              left: 45
            ),
            child:
            new IconButton(
              icon :Icon(Icons.edit,color: Colors.white30,size: 30),
              onPressed: (){
                print('addsnap');
              },
            )
          
          ),
          Container(
            margin: EdgeInsets.only(
              left: 45
            ),
            child:
             new IconButton(
              icon: Icon(Icons.favorite,color: Colors.white30,size: 30),
              onPressed: (){
                print('snap');
              },
            )
            
            ),
          Container(
            margin: EdgeInsets.only(
              left: 45
            ),
            child:
            new IconButton(
              icon:Icon(Icons.settings,color: Colors.white30,size: 30),
              onPressed: (){
                print('setting');
              },
            )
           
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
  var data = [
    {
      'title':'PLAYING FOOTBAL WITH FRIEND'
    },{
      'title':'bananababanana'
    },{
      'title':'First time with my dog'
    }
  ];
  
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index){
        return new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Content(data[index])
          ],
        );
      },
    );
  }
}

class Content extends StatefulWidget{
  Map data = new Map();
  Content(this.data);
@override
ContentState createState() {
      return new ContentState(data);
    }

}
class ContentState extends State<Content>{
  Map data = new Map();
  ContentState(this.data);
  @override
  Widget build(BuildContext context){
    return Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      width: 334,
      //height: 157,
      margin: EdgeInsets.all(4),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
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
                new Text('TODAY 23 APRILL',
                        style: TextStyle(fontSize: 13.5,color: Colors.grey[700]),
                        ),
            
            
              ],
            ),
           
          ),
          // Container(

          //   width: 334,
          //   height: 94,
          //   color: Colors.white,
            
           
          // ),
          // new Divider(
          //   height: 0,
          //   color: Colors.grey,
            
          // ),
          /*
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
          */
    
          ConfigurableExpansionTile(
               // headerExpanded: Flexible(child: Center(child: Text("ssssssssssssss"))),
                header: Container(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[                  
                      Container(
                        child: Icon(Icons.mood,size:60,color:Colors.redAccent),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: 10
                        ),
                        width:250 ,
                        child: 
                        
                        new Text(data['title'],
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Color(0xFFF34949)),
                        ),
                        
                        
                        

                      ),
                    ],
                  )
                    ),
                children: [
                  Row(
                    children: <Widget>[
                      Container(
                        color: Colors.black,
                        height: 150,
                      )
                      ],
                  ),
                  // + more params, see example !!
                ],
              ),
          
        
         
        ],
      ),
      


    );
  }

}
