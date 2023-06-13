// ignore_for_file: avoid_print

import 'package:book_club/models/user.dart';
import 'package:book_club/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CurrentUser with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  NativeUserInf ourUserObject = NativeUserInf(); // Change method to variable
  NativeUserInf get getCurrentUsr => ourUserObject;

  Future<String> onStartup() async {
    String retVal = 'error';

    try {
      User? firebaseUser = _auth.currentUser;

      if (firebaseUser != null) {
        NativeUserInf ourUser =
            await NativeDatabase().getUserInfo(firebaseUser.uid);

        if (ourUser != null && ourUser.uid != null) {
          ourUserObject = ourUser; // Store the fetched user data
          retVal = 'success';
        }
      }
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<String> signUpUser(
      String email, String password, String fullName) async {
    String retVal = 'error';
    NativeUserInf user = NativeUserInf();

    if (email.isEmpty || password.isEmpty) {
      print('Email or password is empty');
      return retVal;
    }

    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      user.uid = userCredential.user!.uid;
      user.email = userCredential.user!.email;
      user.fullName = fullName;

      String returnString = await NativeDatabase().createUser(user);

      if (returnString == 'success') {
        retVal = 'success';
      }
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(message: e.message, code: e.code);
    }
    return retVal;
  }

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
      if (ourUser != null && ourUser.uid != null) {
        retVal = 'success';
      }
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(message: e.message, code: e.code);
    }
    return retVal;
  }

  Future<String> logInUserwithGoogle() async {
    String retVal = 'error';
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );

    NativeUserInf user = NativeUserInf();

    try {
      GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth?.idToken,
        accessToken: googleAuth?.accessToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      if (userCredential.additionalUserInfo!.isNewUser) {
        user.uid = userCredential.user?.uid;
        user.email = userCredential.user?.email;
        user.fullName = userCredential.user?.displayName;
        await NativeDatabase().createUser(user);
      }

      NativeUserInf ourUser =
          await NativeDatabase().getUserInfo(userCredential.user!.uid);

      if (ourUser != null && ourUser.uid != null) {
        retVal = 'success';
      }
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(message: e.message, code: e.code);
    }
    return retVal;
  }

  Future<String> signOut() async {
    String retVal = 'error';
    try {
      await _auth.signOut();
      ourUserObject = NativeUserInf(); // Or ourUserObject = null;
      retVal = 'success';
    } catch (e) {
      print(e);
    }
    return retVal;
  }
}
