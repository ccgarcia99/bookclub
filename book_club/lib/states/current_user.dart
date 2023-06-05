// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CurrentUser with ChangeNotifier {
  late String? _uid;
  late String? _email;

  String? get getUID => _uid;
  String? get getEMAIL => _email;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Native sign up with email and password
  Future<String> signUpUser(String email, String password) async {
    String retVal = 'error';

    if (email.isEmpty || password.isEmpty) {
      print('Email or password is empty');
      return retVal;
    }

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        _uid = userCredential.user!.uid;
        _email = userCredential.user!.email!;
        retVal = 'success';
      }
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(message: e.message, code: e.code);
    }
    return retVal;
  }

  // Native email and password
  Future<String> logInUserwithEmail(String email, String password) async {
    String retVal = 'error';

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
        retVal = 'success';
      }
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(message: e.message, code: e.code);
    }
    return retVal;
  }

  // Google sign in token
  Future<String> logInUserwithGoogle() async {
    String retVal = 'error';
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );

    try {
      GoogleSignInAccount? _googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication? _googleAuth =
          await _googleUser?.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: _googleAuth?.idToken,
        accessToken: _googleAuth?.accessToken,
      );
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      _uid = userCredential.user?.uid;
      _email = userCredential.user?.email;
      retVal = 'success';
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(message: e.message, code: e.code);
    }
    return retVal;
  }
}
