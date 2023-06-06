import 'package:cloud_firestore/cloud_firestore.dart';

class NativeUserInf {
  String? uid;
  String? email;
  String? fullname;
  Timestamp? accountCreated;

  NativeUserInf({
    this.uid,
    this.email,
    this.fullname,
    this.accountCreated,
  });
}
