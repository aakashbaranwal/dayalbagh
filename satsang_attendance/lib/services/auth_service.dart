import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:satsang_attendance/home_page.dart';
import 'package:satsang_attendance/login.dart';

class NameValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Name can't be empty";
    }
    if (value.length < 2) {
      return "Name must be at least 2 characters long";
    }
    if (value.length > 50) {
      return "Name must be less than 50 characters long";
    }
    return null;
  }
}

class AuthService {

  handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if(snapshot.hasData) {
          return HomePage();
        }
        else {
          return Login();
        }
      },
    );
  }


  signIn(AuthCredential authCreds) {
    FirebaseAuth.instance.signInWithCredential(authCreds);
  }

  signInWithOTP(smsCode, verId) {
    AuthCredential authCreds = PhoneAuthProvider.getCredential(verificationId: verId, smsCode: smsCode);
    signIn(authCreds);
  }

}



























//
//class AuthService {
//  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//
//  Stream<String> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.map(
//        (FirebaseUser user) => user?.uid,
//      );
//
//  // email and password to sign up
//
//  Future<String> createUserWithEmailAndPassword(
//      String email, String password, String name) async {
//    final currentUser = await _firebaseAuth.createUserWithEmailAndPassword(
//        email: email, password: password);
//
//    // update the username
//
//    var userUpdateInfo = UserUpdateInfo();
//    userUpdateInfo.displayName = name;
//    await currentUser.user.updateProfile(userUpdateInfo);     // instead of currentUser.updateProfile use currentUser.user.updateProfile
//    await currentUser.user.uid;                               // instead of currentUser.uid use currentUser.user.uid
//  }
//
//  // Email and Password Sign In
//
//  Future<String> signInWithEmailAndPassword(
//      String email, String password) async {
//    return (await _firebaseAuth.signInWithEmailAndPassword(
//            email: email, password: password))
//        .user.uid;                                            // use user.uid instead of just uid
//  }
//
//  // Sign Out
//
//    signOut() {
//        return _firebaseAuth.signOut();
//    }
//}
