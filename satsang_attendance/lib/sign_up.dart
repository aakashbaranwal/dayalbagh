import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:satsang_attendance/services/usermanagement.dart';
import 'validator.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  String _email;
  String _phone;
  String _password;

  bool validateStructure(String value){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: Container(
          color: Colors.blue.shade200,
          padding: EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
    //          IconButton(
    //          icon: Icon(Icons.arrow_back),
    //          tooltip: 'Back',
    //          onPressed: () {
    ////            setState(() {
    ////
    ////            });
    //            Navigator.of(context).pushNamed('/landingpage');
    //          },
    //        ),
              TextFormField(
                validator: EmailValidator.validate,
                decoration: InputDecoration(hintText: 'Email'),   // Email
                onChanged: (value) {
                  validateStructure(value);
                  setState(() {
                    _email = value;
                  });
                },
              ),
              SizedBox(height: 15.0),
              TextField(
                decoration: InputDecoration(hintText: 'Password'),
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),

              SizedBox(height: 20.0),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                child: Text('Sign Up'),
                color: Colors.blue,
                textColor: Colors.white,
                elevation: 7.0,
                onPressed: (){
                  FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password).then((signedInUser){
                    ManageUser().storeNewUser(signedInUser.user, context);
                  }).catchError((e){
                    print(e);
                  });
//                  Scaffold.of(context)
//                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                  Navigator.of(context).pushNamed('/landingpage');
                },
              ),

              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.only(top:0.0, bottom: 10.0, left: 0.0, right: 0.0),
                child: FlatButton(
                  child: Text("Already have an account? \n\t\t\t\t\t\t\t\t\t\t Jump in :)"),
                  onPressed: (){
                    Navigator.of(context).pushReplacementNamed('/landingpage');
                  },


                ),
              ),

            ],
          )),
    ));
  }
}
