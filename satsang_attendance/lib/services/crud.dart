import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class crudMethods {

  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser() !=null) {
      print("AAKASH IS LOGGED IN");
      return true;

    } else {
      print("AAKASH IS NOT LOGGED IN");
      return false;
    }
  }

  Future<void> addData(fieldData) async {
    if (isLoggedIn()) {

     // print(fieldData.runtimeType);

    // prints the data type of the fieldData
   //   List responseJson = json.decode(fieldData.body.toString());


      Firestore.instance.collection('field_work').add(fieldData).catchError((e) {
        print(e);
      });
    } else {
      print('You need to be logged in');
    }
  }


  Future<void> addData_in_user_account_details(fieldData_of_user_account_profile) async {
    if (isLoggedIn()) {

      // print(fieldData.runtimeType);

      // prints the data type of the fieldData
      //   List responseJson = json.decode(fieldData.body.toString());


      Firestore.instance.collection('users_account_details').add(fieldData_of_user_account_profile).catchError((e) {
        print(e);
        print("USername: $fieldData_of_user_account_profile");
      });
    } else {
      print('You need to be logged in');
    }
  }

  getData() async {
    return await Firestore.instance.collection('field_work').getDocuments();
  }

  getData_user_account_details() async {
    return await Firestore.instance.collection('users_account_details').getDocuments();
  }


}