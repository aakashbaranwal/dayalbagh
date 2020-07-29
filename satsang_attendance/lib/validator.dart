import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailValidator {

  static String validate(String value) {
    if(value.isEmpty) {
      return "Email can't be empty";
    }
    return null;
  }
}