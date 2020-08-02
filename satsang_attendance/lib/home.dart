import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'services/crud.dart';

class User_Home extends StatefulWidget {
  @override
  _User_HomeState createState() => _User_HomeState();
}

class _User_HomeState extends State<User_Home> {

  Map data;

  String uid, location, day, date, shift;

  QuerySnapshot fields;     // this will store the data when the app reads the firebase database and then we will use it to get the values of the fields we want

  crudMethods crudObj = new crudMethods();

  Future<bool> addDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Data', style: TextStyle(fontSize: 15),),
          content: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(hintText: "Enter UID"),
                onChanged: (value) {
                  this.uid = value;
                },
              ),

              SizedBox(height: 5,),
              TextField(
                decoration: InputDecoration(hintText: "Enter Location"),
                onChanged: (value){
                  this.location = value;
                },
              ),


              SizedBox(height: 5,),
              TextField(
                decoration: InputDecoration(hintText: "Enter Day"),
                onChanged: (value){
                  this.day = value;
                },
              ),

              SizedBox(height: 5,),
              TextField(
                decoration: InputDecoration(hintText: "Enter Date"),
                onChanged: (value){
                  this.date = value;
                },
              ),

              SizedBox(height: 5,),
              TextField(
                decoration: InputDecoration(hintText: "Enter Shift (Morning or Evening?)"),
                onChanged: (value){
                  this.shift = value;
                },
              ),




            ],
          ),

          actions: <Widget>[
            FlatButton(
              child: Text('Add'),
              textColor: Colors.blue,
              onPressed: () {
                Navigator.of(context).pop();

               // https://stackoverflow.com/questions/49824167/breaking-exception-internallinkedhashmapdynamic-dynamic-is-not-a-subtype-o
                // checkout the above link to know what the below code will do with Map<String, String> fieldData
                // without this the compiler had been showing error: " type '_InternalLinkedHashMap<dynamic, dynamic>' is not a subtype of type 'Map<String, dynamic>'"
                // i checked the type of the fieldData and it returned as _InternalLinkedHashMap<dynamic, dynamic> using "fieldData.runtimeType"
                // with adding <String, String>  below, it is now sending the data onto the cloud firestore database in real time which it was not earlier without this

                Map<String, String> fieldData = {
                  'Unique ID': this.uid,
                  'Location of Field': this.location,
                  'Day':this.day,
                  'Date': this.date,
                  'Shift': this.shift
                };

                crudObj.addData(fieldData).then((result) {
                  dialogTrigger(context);

                }).catchError((e) {
                  print(e);
                });
              },
            ),
          ],

        );
      });
  }


  Future<bool> dialogTrigger(BuildContext context) async{
    return showDialog(context: context,
    barrierDismissible: false,
      builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Job Done', style: TextStyle(fontSize: 15),),
        content: Text('Added'),
        actions: <Widget>[
          FlatButton(
            child: Text('Alright'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      );
      });
  }


  @override
  void initState() {
    crudObj.getData().then((results) {
       setState(() {
         fields = results;
       });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: <Widget>[


            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                addDialog(context);
              },
            ),


            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                crudObj.getData().then((results) {
                  setState(() {
                    fields = results;

                    print("Aakash");
                    print("$results");
                    print("Baranwal");

                  });
                });
              },
            ),




            SizedBox(height: 30,),
            Text(
              data.toString(),
              textAlign: TextAlign.center,
            )
          ],
        ),

        body: _fieldDetails()),
      );




  }
  Widget _fieldDetails() {
    if (fields != null) {
      return ListView.builder(

          itemCount: fields.documents.length,
          padding: EdgeInsets.all(5),
          itemBuilder: (context, i) {
            if((fields.documents[i].data['Unique ID'] != null) && (fields.documents[i].data['Location of Field'] != null)) {
              return new Container(
                child: Column(
                  children: <Widget>[
                    Row(
                    children: <Widget>[
                      Text('Unique ID:', style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(width: 10),
                      Text(fields.documents[i].data['Unique ID']),
                    ],
                    ),


                    Row(
                      children: <Widget>[
                        Text('Location of Field:', style: TextStyle(fontWeight: FontWeight.bold),),
                        SizedBox(width: 10),
                        Text(fields.documents[i].data['Location of Field']),
                      ],
                    ),


                    Row(
                      children: <Widget>[
                        Text('Day:', style: TextStyle(fontWeight: FontWeight.bold),),
                        SizedBox(width: 10),
                        Text(fields.documents[i].data['Day']),
                      ],
                    ),


                    Row(
                      children: <Widget>[
                        Text('Date:', style: TextStyle(fontWeight: FontWeight.bold),),
                        SizedBox(width: 10),
                        Text(fields.documents[i].data['Date']),
                      ],
                    ),


                    Row(
                      children: <Widget>[
                        Text('Shift:', style: TextStyle(fontWeight: FontWeight.bold),),
                        SizedBox(width: 10),
                        Text(fields.documents[i].data['Shift']),
                      ],
                    ),

                    SizedBox(height: 20,),
                  ],
                ),


              );
            }
            else {
              return new ListTile(
                title: Text("Default"),
                // == null? fields.documents[i].data['UID'] : 'default values' ),

                subtitle: Text("Default"),
              );
            };

          });
    } else {
      return Text('Loading, Please wait...');
    }

  }
}



