import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:satsang_attendance/account_setup_details.dart';

class ProfileView extends StatelessWidget {

  String name_of_user, satsand_uid, branch_name, email, phone_number, gender, current_address;

  ProfileView({this.name_of_user, this.satsand_uid, this.branch_name, this.email, this.phone_number, this.gender, this.current_address});

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  Future<String> getCurrentUID() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/homepage');// do something
              },
            ),


            IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/account');// do something
              },
            ),



          ],

        ),
      body: Column(
        children: <Widget>[
          Text("Name of User: $name_of_user"),
          Text("Satsang UID: $satsand_uid"),
          Text("Name of Branch: $branch_name"),
          Text("Email Address: $email"),
          Text("Phone Number: $phone_number"),
          Text("Gender: $gender"),
          Text("Address: $current_address"),
        ],
      ),
      ),
    );


//
//    return MaterialApp(
//
//      home: Column(
//        children: <Widget>[
//          SingleChildScrollView(
//            child: Container(
//              child: Column(
//                children: <Widget>[
//                  Text("Details"),
//                  Column(
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                    children: <Widget>[
//                      Align(
//                        alignment: Alignment.center,
//                        child: //Account_setup_page()
//
//                        Text(name_of_user, style: TextStyle(color: Colors.blueGrey, fontSize: 15.0),
//                        ),
//                      ),
//
//
//                      Align(
//                        alignment: Alignment.center,
//                        child: Text(satsand_uid, style: TextStyle(color: Colors.blueGrey, fontSize: 18.0),
//                        ),
//                      ),
//
//
//                      Align(
//                        alignment: Alignment.center,
//                        child: Text(branch_name, style: TextStyle(color: Colors.blueGrey, fontSize: 18.0),
//                        ),
//                      ),
//
//
//                      Align(
//                        alignment: Alignment.center,
//                        child: Text(email, style: TextStyle(color: Colors.blueGrey, fontSize: 18.0),
//                        ),
//                      ),
//
//
//
//                      Align(
//                        alignment: Alignment.center,
//                        child: Text(phone_number, style: TextStyle(color: Colors.blueGrey, fontSize: 18.0),
//                        ),
//                      ),
//
//
//                      Align(
//                        alignment: Alignment.center,
//                        child: Text(gender, style: TextStyle(color: Colors.blueGrey, fontSize: 18.0),
//                        ),
//                      ),
//
//
//                      Align(
//                        alignment: Alignment.center,
//                        child: Text(current_address, style: TextStyle(color: Colors.blueGrey, fontSize: 38.0),
//                        ),
//                      ),
//IconButton(
//  icon: Icon(Icons.add),
//  onPressed: (){
//          Navigator.of(context).pushReplacementNamed('/account');
//  },
//)
//
//                    ],
//                  ),
//                ],
//              ),
//            ),
//
//          ),
//        ],
//      ),
//    );
  }
}
