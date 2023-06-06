// ignore_for_file: avoid_print

import 'package:book_club/models/user.dart';
import 'package:book_club/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CurrentUser with ChangeNotifier {
  NativeUserInf ourUser() => NativeUserInf();

  NativeUserInf get getCurrentUsr => ourUser();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> onStartup() async {
    String retVal = 'error';
    // retval always returns 'error'. why?
    //TODO: Investigate
    try {
      User? firebaseUser = await _auth.currentUser;
      if (firebaseUser != null) {
        NativeUserInf ourUser =
            await NativeDatabase().getUserInfo(firebaseUser.uid);
        if (ourUser != null) {
          retVal = 'success';
        }
      }
      retVal = 'success';
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<String> signOut() async {
    String retVal = 'error';
    try {
      await _auth.signOut();
      // ignore: unused_local_variable
      NativeUserInf ourUser = NativeUserInf();
      retVal = 'success';
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  // Native sign up with email and password
  Future<String> signUpUser(
      String email, String password, String fullName) async {
    String retVal = 'error';
    NativeUserInf _user = NativeUserInf();

    if (email.isEmpty || password.isEmpty) {
      print('Email or password is empty');
      return retVal;
    }

    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      _user.uid = userCredential.user!.uid;
      _user.email = userCredential.user!.email;
      _user.fullname = fullName;
      NativeDatabase().createUser(_user);
      String _returnString = await NativeDatabase().createUser(_user);

      if (_returnString == 'success') {
        retVal = 'success';
      }

      // DO NOT TOUCH THE BOTTOM CODE FOR NOW
      /*if (userCredential.user != null) {
        ourUser().uid = userCredential.user!.uid;
        ourUser().email = userCredential.user!.email!;
        retVal = 'success';
      }*/
      // BOTTOM CODE ENDS
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
      NativeUserInf ourUser =
          await NativeDatabase().getUserInfo(userCredential.user!.uid);
      if (ourUser != null) {
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

    NativeUserInf _user = NativeUserInf();

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

      if (userCredential.additionalUserInfo!.isNewUser) {
        _user.uid = userCredential.user?.uid;
        _user.email = userCredential.user?.email;
        _user.fullname = userCredential.user?.displayName;
        NativeDatabase().createUser(_user);
      }

      NativeUserInf ourUser =
          await NativeDatabase().getUserInfo(userCredential.user!.uid);

      if (ourUser != null) {
        retVal = 'success';
      }
      /*    DO NOT TOUCH! NOLI SE TANGERE
      ourUser().uid = userCredential.user?.uid;
      ourUser().email = userCredential.user?.email; */
      retVal = 'success';
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(message: e.message, code: e.code);
    }
    return retVal;
  }
}
