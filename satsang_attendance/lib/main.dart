import 'package:flutter/material.dart';
import 'login.dart';
import 'sign_up.dart';
import 'home_page.dart';

void main() => runApp(satsangi_attendance());

class satsangi_attendance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
      routes: <String, WidgetBuilder> {
        '/landingpage': (BuildContext context)=> new satsangi_attendance(),     // this is for the login page in the app
        '/signup': (BuildContext context)=> new Signup(),                       // this is for the sign up page in the app
        '/homepage': (BuildContext context)=> new HomePage(),                   // this is for the home page in the app which comes after signing in
      },
    );
  }
}
