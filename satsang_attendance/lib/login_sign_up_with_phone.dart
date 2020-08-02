import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:satsang_attendance/services/auth_service.dart';
import 'package:satsang_attendance/services/usermanagement.dart';


class Signup_Phone extends StatefulWidget {
  @override
  _Signup_PhoneState createState() => _Signup_PhoneState();
}

class _Signup_PhoneState extends State<Signup_Phone> {

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

                  Padding(
                    padding: EdgeInsets.only(left: 25.0, right: 25.0),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(hintText: 'Enter Phone Number'),
                      onChanged: (val)
                      {
                        setState(() {
                          this.phoneNo = val;

                        });

                      },
                    ),
                  ),


                  codeSent ? Padding(
                    padding: EdgeInsets.only(left: 25.0, right: 25.0),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(hintText: 'Enter OTP'),
                      onChanged: (val) {
                        new FlatButton(
                            onPressed: _toggle,
                            child: Icon(Icons.remove_red_eye)
                          //new Text(_obscureText ? "Show" : "Hide"),
                        );
                        setState(() {

                          this.smsCode = val;
                        });
                      },
                    ),
                  ): Container(),



                  Padding(
                    padding: EdgeInsets.only(left: 25, right: 25),
                    child: RaisedButton(
                      child: Center(
                          child: codeSent ? Text('Login') : Text('Verify')),

                      onPressed: () {
                        codeSent? AuthService().signInWithOTP(smsCode, verificationId) : verifyPhone(phoneNo);
                        print("CodeSent: $codeSent");
                        Navigator.of(context).pushReplacementNamed('/homepage');
//                        if(codeSent  == false){
//                          Navigator.of(context).pushReplacementNamed('/account');
//                          print('going to account');
//                        }
//                        else if (codeSent  == true){
//                          Navigator.of(context).pushReplacementNamed('/homepage');
//                          print('going to homepage');
//                        }
                      },
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

  Future<void> verifyPhone(phoneNo) async {

    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
     // Navigator.of(context).pushReplacementNamed('/homepage');
    };

    final PhoneVerificationFailed verificationFailed = (AuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeOut = (String verId) {
      this.verificationId = verId;
    };


    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationFailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeOut);

  }
}
