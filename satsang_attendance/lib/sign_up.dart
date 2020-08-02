import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:satsang_attendance/account_setup_details.dart';
import 'package:satsang_attendance/services/auth_service.dart';
import 'package:satsang_attendance/services/usermanagement.dart';


class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  String _email;
  String _password;

  String phoneNo, verificationId, smsCode;
  bool codeSent = false;

  final formKey = new GlobalKey<FormState>();


  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

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

              TextFormField(
                //validator: EmailValidator.validate,
                decoration: const InputDecoration(
              labelText: 'Email',
              icon: const Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: const Icon(Icons.email))),
                onChanged: (value) {
                  validateStructure(value);
                  setState(() {
                    _email = value;
                  });
                },
              ),
              SizedBox(height: 15.0),
              Column(
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Password',
                        icon: const Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: const Icon(Icons.lock),
                        )
                    ),

                    validator: (val) => val.length < 6 ? 'Password too short.' : null,
                    onSaved: (val) => _password = val,
                    obscureText: _obscureText,
                  ),
                  new FlatButton(
                      onPressed: _toggle,
                      child: Icon(Icons.remove_red_eye)
                    //new Text(_obscureText ? "Show" : "Hide"),
                  ),
                ],
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
                    print("Logged IN");
                  }).catchError((e){
                    print(e);
                  });
//                  Scaffold.of(context)
//                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                  //Navigator.of(context).pushNamed('/landingpage');



                },
              ),


              SizedBox(
                height: 20.0,
                width: 150.0,
                child: Divider(
                  color: Colors.deepPurple,
                ),
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
