// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CurrentUser with ChangeNotifier {
  late String _uid;
  late String _email;

  String get getUID => _uid;
  String get getEMAIL => _email;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> signUpUser(String email, String password) async {
    bool retVal = false;

    if (email.isEmpty || password.isEmpty) {
      print('Email or password is empty');
      return retVal;
    }

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        _uid = userCredential.user!.uid;
        _email = userCredential.user!.email!;
        retVal = true;
      }
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<bool> logInUser(String email, String password) async {
    bool retVal = false;

    if (email.isEmpty || password.isEmpty) {
      print('Email or password is empty');
      return retVal;
    }

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        _uid = userCredential.user!.uid;
        _email = userCredential.user!.email!;
        retVal = true;
      }
    } catch (e) {
      print(e);
    }
    return retVal;
  }
}
