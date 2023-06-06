// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers

import 'package:book_club/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NativeDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createUser(NativeUserInf user) async {
    String retVal = 'error';

    try {
      await _firestore.collection('users').doc(user.uid).set({
        'fullName': user.fullname,
        'email': user.email,
        'accountCreated': Timestamp.now(),
      });
      retVal = 'success';
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<NativeUserInf> getUserInfo(String uid) async {
    NativeUserInf retVal = NativeUserInf();

    try {
      DocumentSnapshot _docSnap =
          await _firestore.collection('users').doc(uid).get();
      retVal.uid = uid;
      retVal.fullname = _docSnap.get("fullName");
      retVal.email = _docSnap.get("email");
      retVal.accountCreated = _docSnap.get("accountCreated");
    } catch (e) {
      print(e);
    }

    return retVal;
  }
}
