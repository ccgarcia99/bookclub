import 'package:cloud_firestore/cloud_firestore.dart';

class NativeUserInf {
  String? uid;
  String? email;
  String? fullName;
  Timestamp? accountCreated;
  String? groupId;

  NativeUserInf({
    this.uid,
    this.email,
    this.fullName,
    this.accountCreated,
    this.groupId
  });
}
