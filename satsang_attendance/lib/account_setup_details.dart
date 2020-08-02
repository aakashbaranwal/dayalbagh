import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:satsang_attendance/profile_view.dart';
import 'services/crud.dart';

class Account_setup_page extends StatefulWidget {
  @override
  _Account_setup_pageState createState() => _Account_setup_pageState();
}

class _Account_setup_pageState extends State<Account_setup_page> {
  Map data;

  String name,
      satsand_uid,
      branch,
      email_id,
      phone_number,
      gender,
      current_address;

  QuerySnapshot
      personal_details; //fields;     // this will store the data when the app reads the firebase database and then we will use it to get the values of the fields we want

  crudMethods crudObj = new crudMethods();

  Future<bool> addDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'User Account Details',
              style: TextStyle(fontSize: 15),
            ),
            content: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(hintText: "Full Name"),
                  onChanged: (value) {
                    this.name = value;
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  decoration: InputDecoration(hintText: "UID of Satsang"),
                  onChanged: (value) {
                    this.satsand_uid = value;
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  decoration: InputDecoration(hintText: "Enter Branch Name"),
                  onChanged: (value) {
                    this.branch = value;
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  decoration: InputDecoration(hintText: "Enter Email"),
                  onChanged: (value) {
                    this.email_id = value;
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  decoration: InputDecoration(hintText: "Enter Phone Number"),
                  onChanged: (value) {
                    this.phone_number = value;
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  decoration: InputDecoration(hintText: "Enter Gender"),
                  onChanged: (value) {
                    this.gender = value;
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  decoration:
                      InputDecoration(hintText: "Enter Current Address"),
                  onChanged: (value) {
                    this.current_address = value;
                  },
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Submit'),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();


                  // https://stackoverflow.com/questions/49824167/breaking-exception-internallinkedhashmapdynamic-dynamic-is-not-a-subtype-o
                  // checkout the above link to know what the below code will do with Map<String, String> fieldData_of_user_account_profile
                  // without this the compiler had been showing error: " type '_InternalLinkedHashMap<dynamic, dynamic>' is not a subtype of type 'Map<String, dynamic>'"
                  // i checked the type of the fieldData_of_user_account_profile and it returned as _InternalLinkedHashMap<dynamic, dynamic> using "fieldData_of_user_account_profile.runtimeType"
                  // with adding <String, String>  below, it is now sending the data onto the cloud firestore database in real time which it was not earlier without this

                  Map<String, String> fieldData_of_user_account_profile = {
                    'Full Name': this.name,
                    'Satsang UID': this.satsand_uid,
                    'Branch Name': this.branch,
                    'Email': this.email_id,
                    'Phone Number': this.phone_number,
                    'Gender': this.gender,
                    'Current Address': this.current_address,
                  };

                  crudObj
                      .addData_in_user_account_details(
                          fieldData_of_user_account_profile)
                      .then((result) {
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

  Future<bool> dialogTrigger(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Job Done',
              style: TextStyle(fontSize: 15),
            ),
            content: Text('Added'),
            actions: <Widget>[
              FlatButton(
                child: Text('Alright'),
                onPressed: () {
                  //Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProfileView(
                        name_of_user: name,
                        satsand_uid: satsand_uid,
                        branch_name: branch,
                        email: email_id,
                        phone_number: phone_number,
                        gender: gender,
                        current_address: current_address),
                  ));
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
        personal_details = results;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 50.0),
              child: Text(
                'Create Account',
                style: TextStyle(color: Colors.yellow, fontSize: 25),
              ),
            ),
          ),
          backgroundColor: Colors.black,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              color: Colors.yellow,
              onPressed: () {
                addDialog(context);
              },
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              data.toString(),
              textAlign: TextAlign.center,
            )
          ],
        ),
        body: _fieldDetails(),
      ),
    );
  }

  Widget _fieldDetails() {
    if (personal_details != null) {
      return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: personal_details.documents.length,
          padding: EdgeInsets.all(5),
          itemBuilder: (context, i) {
            if ((personal_details.documents[i].data['Full Name'] != null) &&
                (personal_details.documents[i].data['UID of Satsang'] !=
                    null)) {
              return new Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'Full Name:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10),
                        Text(personal_details.documents[i].data['Full Name']),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'UID of Satsang:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10),
                        Text(personal_details
                            .documents[i].data['UID of Satsang']),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Branch Name:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10),
                        Text(personal_details.documents[i].data['Branch Name']),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Email:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10),
                        Text(personal_details.documents[i].data['Email']),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Phone Number:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10),
                        Text(
                            personal_details.documents[i].data['Phone Number']),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              );
            } else {
              return new ListTile(
                title: Text(" "),
                // == null? personal_details.documents[i].data['Full Name'] : 'default values' ),

                subtitle: Text(" "),
              );
            }
            ;
          });
    } else {
      return Text('Loading, Please wait...');
    }
  }
}
