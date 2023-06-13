// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers

import 'package:book_club/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NativeDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createUser(NativeUserInf user) async {
    String retVal = 'error';

    try {
      await _firestore.collection('users').doc(user.uid).set({
        'fullName': user.fullName,
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
      retVal.fullName = _docSnap['fullName'];
      retVal.email = _docSnap['email'];
      retVal.accountCreated = _docSnap['accountCreated'];
      retVal.groupId = _docSnap['groupId'];
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<String> createGroup(String groupName, String? userID) async {
    String retVal = 'error';
    List<String> members = [];

    try {
      if (userID == null) {
        retVal = 'error';
      } else {
        members.add(userID);
        DocumentReference docRef = await _firestore.collection("groups").add({
          'name': groupName,
          'leader': userID,
          'members': members,
          'groupCreate': Timestamp.now(),
        });
        await _firestore.collection("users").doc(userID).update({
          'groupId': docRef.id,
        });
        retVal = 'success'; // Moved inside the else block
      }
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<String> joinGroup(String groupID, String userID) async {
    String retVal = 'error';
    List<String> members = [];
    try {
      members.add(userID);
      await _firestore.collection("groups").doc(groupID).update({
        'members': FieldValue.arrayUnion(members),
      });
      await _firestore.collection("users").doc(userID).update({
        'groupId': groupID,
      });

      retVal = 'success';
    } catch (e) {
      print(e);
    }

    return retVal;
  }
}
