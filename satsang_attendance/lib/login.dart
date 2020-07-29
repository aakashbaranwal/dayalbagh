import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'validator.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String _email;
  String _phone;
  String _password;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
//      appBar: AppBar(
//        //Icon: Icons.arrow_left,
//      ),
      body: Center(
        child: Container(
          color: Colors.blue.shade200,
          padding: EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
         //     Image.asset('images/me.png'),
              TextFormField(
                validator: EmailValidator.validate,
                decoration: InputDecoration(hintText: 'Email'),   // Email
                onChanged: (value) {
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

                child: Padding(
                  padding: const EdgeInsets.only(top:10.0, bottom: 10.0, left: 30.0, right: 30.0),
                  child: Text('Login'),
                ),
                color: Colors.blue,
                textColor: Colors.white,
                elevation: 7.0,
                onPressed: (){

                  FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password).then((AuthResult user) {
                    Navigator.of(context).pushReplacementNamed('/homepage');
                  }).catchError((e) {
                    print(e);
                  });
                },
                ),

              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.only(top:0.0, bottom: 10.0, left: 0.0, right: 0.0),
                child: FlatButton(
                  child: Text("Don't have an account yet? \n\t\t\t\t\t\t\t\t Create one :)"),
                    onPressed: (){
                      Navigator.of(context).pushReplacementNamed('/signup');
                    },


                ),
              ),
              
//              RaisedButton(
//                shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(30.0)),
//
//                child: Padding(
//                  padding: const EdgeInsets.only(top:10.0, bottom: 10.0, left: 30.0, right: 30.0),
//                  child: Text('Sign Up'),
//                ),
//                color: Colors.blue,
//                textColor: Colors.white,
//                elevation: 7.0,
//                onPressed: (){
//                  Navigator.of(context).pushNamed('/signup');
//                },
//              )
            ],
          ),
        ),
      ),
    );
  }
}
