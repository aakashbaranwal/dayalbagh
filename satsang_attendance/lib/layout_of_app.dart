//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
//import 'package:curved_navigation_bar/curved_navigation_bar.dart';
//import 'package:satsang_attendance/profile.dart';
//import 'package:satsang_attendance/report.dart';
//import 'home_page.dart';
//
//class Layout extends StatefulWidget {
//  @override
//  _LayoutState createState() => _LayoutState();
//}
//
//class _LayoutState extends State<Layout> {
//
//  int _currentIndex = 0;    // currentIndex will selecting the menu in the bottom widgets
//
//  int _page = 0;
//  GlobalKey _bottomNavigationKey = GlobalKey();
//
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      //      body: Container(),
//      appBar: new AppBar(
//        title: new Text('Layout'),
//        backgroundColor: Colors.black,
//        centerTitle: true,
//
//        actions: <Widget>[
//          IconButton(
//            icon: Icon(
//              Icons.exit_to_app,
//              color: Colors.white,
//            ),
//            onPressed: () {
//
//              FirebaseAuth.instance.signOut().then((value) {
//                Navigator.of(context).pushReplacementNamed('/landingpage');
//              }).catchError((e) {
//                print(e);
//              });
//              // do something
//            },
//          )
//        ],
//
//      ),
//
//      bottomNavigationBar: CurvedNavigationBar(
//        color: Colors.black,
//        backgroundColor: Colors.white,
//        buttonBackgroundColor: Colors.black,
//
//        items: <Widget>[
//          //  Icon(Icons.home, color: Colors.white,),
//          IconButton(icon: Icon(Icons.home, color: Colors.white,),onPressed: (){
////
////            Navigator.push(context, new MaterialPageRoute(
////                builder: (context) => new HomePage())
////            );
//
//          },),
//
//          IconButton(icon: Icon(Icons.insert_chart, color: Colors.white,),onPressed: (){
//
////            Navigator.push(context, new MaterialPageRoute(
////                builder: (context) => new Report())
////            );
//
//          },),
//
//          IconButton(icon: Icon(Icons.person, color: Colors.white,),onPressed: (){
//
////            Navigator.push(context, new MaterialPageRoute(
////                builder: (context) => new Profile())
////            );
//          },),
//
//        ],
//
//        animationDuration: Duration(milliseconds: 100),
//        animationCurve: Curves.bounceInOut,
//        onTap: (index) {
//          setState(() {
//            _currentIndex = index;
//          });
//
//          },
//      ),
//
//
//      body: Container(),
//
//    );
//  }
//}
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
////
////onTap: (index) {
////switch (index) {
////case 0:
////_navigatorKey.currentState.pushReplacementNamed("Home");
////break;
////case 1:
////_navigatorKey.currentState.pushReplacementNamed("Report");
////break;
////case 2:
////_navigatorKey.currentState.pushReplacementNamed("Profile");
////break;
////}
////
////setState(() {
////_currentIndex = index;
////});
////
////Route<dynamic> generateRoute(RouteSettings settings) {
////switch (settings.name) {
////case "Account":
////return MaterialPageRoute(builder: (context) => Container(color: Colors.blue,child: Center(child: Text("Account"))));
////case "Settings":
////return MaterialPageRoute(builder: (context) => Container(color: Colors.green,child: Center(child: Text("Settings"))));
////default:
////return MaterialPageRoute(builder: (context) => Container(color: Colors.white,child: Center(child: Text("Home"))));
////}
////}
////},