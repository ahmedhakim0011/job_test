import 'package:cloud_firestore/cloud_firestore.dart';

class Userinfo {
  String? Id;
  String? userWeight;
  Timestamp? time;

  Userinfo({this.Id, this.userWeight, this.time});
}
