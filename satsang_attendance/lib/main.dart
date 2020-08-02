import 'package:flutter/material.dart';
import 'package:satsang_attendance/account_setup_details.dart';
import 'package:satsang_attendance/profile.dart';
import 'package:satsang_attendance/profile_view.dart';
import 'login.dart';
import 'sign_up.dart';
import 'home_page.dart';
import 'services/auth_service.dart';
import 'views/sign_up_view.dart';

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
        '/profile': (BuildContext context)=> new Profile(),                     // this is for the profile page in the app
        '/account': (BuildContext context)=> new Account_setup_page(),           // this is for the account creation page in the app
        '/profile_view': (BuildContext context)=> new ProfileView(),           // this is for the account creation page in the app



        // one very important thing is that the above routes are not made in any normal class but are valid when it is a stateful or a stateless widget
      },
    );
  }
}
