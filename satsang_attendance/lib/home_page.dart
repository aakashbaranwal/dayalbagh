import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:satsang_attendance/account_setup_details.dart';
import 'package:satsang_attendance/home.dart';
import 'package:satsang_attendance/mains.dart';
import 'package:satsang_attendance/profile.dart';
import 'package:satsang_attendance/profile_view.dart';
import 'package:satsang_attendance/report.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  int index;

  final List<Widget> _children = [
    User_Home(), Report(), ProfileView(), MyApp(), Account_setup_page()     //  MyApp(), Profile() and ProfileView are for profiles

    //  for adding details use User_Home() or Account_setup_page()...use any one to check out.
    //  Account_setup_page() will be used while signing up and User_Home() will remain permanent

  ];

  final List Page_heading = ['Home', 'Report', 'Profile'];

  int _currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //      body: Container(),
      appBar: new AppBar(
        title: new Text(Page_heading[_currentIndex]),
        backgroundColor: Colors.black,
        centerTitle: true,

        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onPressed: () {

              FirebaseAuth.instance.signOut().then((value) {
                Navigator.of(context).pushReplacementNamed('/landingpage');
              }).catchError((e) {
                print(e);
              });
              // do something
            },
          )
        ],

      ),
      body: _children[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
          },

        currentIndex: _currentIndex,

        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text("Home"),
          ),

          BottomNavigationBarItem(
            icon: new Icon(Icons.insert_chart),
            title: new Text("Report"),
          ),

          BottomNavigationBarItem(
            icon: new Icon(Icons.person),
            title: new Text("Profile"),
          ),

        ],

      )

//      CurvedNavigationBar(
//
//        color: Colors.black,
//        //buttonBackgroundColor: Colors.yellow,
//        height: 50,
//
//        items: <Widget>[
//
//
//        Icon(Icons.home, size: 30, color: Colors.yellow,),
//        Icon(Icons.insert_chart, size: 30, color: Colors.yellow),
//        Icon(Icons.person, size: 30, color: Colors.yellow),
//
//      ],
//
//        animationDuration: Duration(milliseconds: 100),
//        animationCurve: Curves.bounceInOut,
//
//        onTap: (index) {
//          _currentIndex = _currentIndex;
//          setState(() {
//            _currentIndex = index;
//          });
//        },
//
//      ),

          );
  }
}
