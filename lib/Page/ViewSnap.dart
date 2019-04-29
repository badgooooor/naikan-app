import 'package:flutter/material.dart';
import 'package:event_bus/event_bus.dart';
import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';
import 'package:naikan/Model/Model.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:naikan/main.dart';
import 'package:naikan/Page/footer.dart';

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

  Api api = new Api();
  DateTime test_ym = new DateTime.now();
  List<Snapshot> ym;
   getyearmont() async{
    ym = await api.getSnapshotYearMonth(test_ym.year,test_ym.month);
    // print('in getFunction'+ym.toString());
  }


Future<Null> selectYearMonth(BuildContext context) async{
    final DateTime pickedYearMonth = await showMonthPicker(
      context: context,initialDate: DateTime(2019)
    );
        if(pickedYearMonth != null){
          test_ym = pickedYearMonth;
          // print('in SelevtYearMonth'+ym.toString());
          await getyearmont();
          eventBus.fire(ym);
    }
  }
  //static const PrimaryColor = const Color(0xFFFFFF100);
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xFFF34343),
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
              selectYearMonth(context);
              print('searchhh');
             
            },
          )
        ],
        backgroundColor: new Color(0xFFF34343),
        
       // backgroundColor: PrimaryColor,
        centerTitle: true ,
        title: Text('SNAPSHOT'),
        
      ),
      body: new Stack(
        children: <Widget>[
          Viewsnap(),
          new Footer(),
        ],
      )
      //bottomNavigationBar: Footer(),
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
            mainAxisAlignment: MainAxisAlignment.start,
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
  List<Snapshot> ym = new List();

  Api api = new Api(); 
 // DateTime test_ym = new DateTime.now();
  @override
  void dispose(){
    super.dispose();
    ym = new List();
  }
  @override
  initState() {
    super.initState();
    eventBus.on().listen((event) {
     
      setState(() {
         ym = event;

      });
     
 
      
  });
   
  }

  List<Snapshot> data;
  getAll() {
    return api.getSnapshotAll();
  }
  

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:getAll(),
        builder:(context , snapshot){
          if(snapshot.connectionState == ConnectionState.waiting ){
            
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white70))
                  ],
                )
              ],
            ); 
            
          }
        
          if(ym.length != 0){
            return listView(ym); 
          }
          if (snapshot.connectionState == ConnectionState.done){
            return listView(snapshot.data);
          }
         

      });

    }
}
class listView extends StatefulWidget{
  List<Snapshot> data = new List();
  listView(this.data);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return listViewState(data);
  }


  } 
class listViewState extends State<listView>{
  List<Snapshot> data = new List();
  listViewState(this.data);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  new ListView.builder(
      
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index){
        return new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Content(data[index])
          ],
        );
      },
    );;
  }

  
}

class Content extends StatefulWidget{
  Snapshot data = new Snapshot();
  Content(this.data);
@override
ContentState createState() {
      return new ContentState(data);
    }

}
class ContentState extends State<Content>{
  Snapshot data = new Snapshot();
  String getStingDate(int date){  
    
    int y = date~/10000;
    int d = date%100;
    int m = (date~/100)%100;
        var month = ['January', 'February', 'March',
    'April', 'May', 'June',
    'July', 'August', 'September',
    'October', 'November', 'December'
    ];
    if(date!=0)
      return  d.toString()+'  ' +month[m-1] +'  ' + y.toString();
    else 
      return '';//'No snapshot here :)';
  }
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
                new Text(getStingDate(data.date),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[                  
                      Container(
                        child: Icon(Icons.mood,size:60,color:Colors.redAccent),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                              left: 10
                            ),
                            width:250 ,
                            child: 
                            new Text(data.title,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Color(0xFFF34949)),
                            ),
                            
                          ),
                          Container(
                            
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text('  '),
                                Icon(Icons.access_time,size: 20,color: Colors.red[300],),
                                Text(' '),
                                Text(data.time),
                                //
                              ],
                            )
                          ),
                          Container(
                            child: Row(
                            
                              children: <Widget>[
                                Text('  '),
                                Icon(Icons.location_on,size: 20,color: Colors.red[300]),
                                Text(' '),
                                Text(data.place),
                                                                   
                              ],
                            )
                          ),
                          
                        ],
                      ),

                    ],
                  )
                  
                ),
                
                  
                children: [
                  Row(
                    children: <Widget>[
                      Container(
                        
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
