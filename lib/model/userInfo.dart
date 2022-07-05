import 'package:cloud_firestore/cloud_firestore.dart';

class Userinfo {
  String? docid;
  String? userWeight;
  Timestamp? time;

  Userinfo({this.docid, this.userWeight, this.time});
}
