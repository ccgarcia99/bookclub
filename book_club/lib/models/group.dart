import 'package:cloud_firestore/cloud_firestore.dart';

class GroupModel {
  String? id;
  String? name;
  String? admin;
  List<String>? members;
  Timestamp? groupCreated;

  GroupModel({
    this.id,
    this.name,
    this.admin,
    this.members,
    this.groupCreated,
  });
}
