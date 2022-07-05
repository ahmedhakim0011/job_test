import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:job_test/model/userInfo.dart';

class UserInfoProvider with ChangeNotifier {
  DocumentSnapshot? docid;

  void addUserInfo({
    String? ID,
    String? userWeight,
    Timestamp? time,
  }) async {
    await FirebaseFirestore.instance
        .collection('UserWeight')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'userWeight': userWeight, 'timestamp': DateTime.now()});
  }

  List<Userinfo> userDataList = [];
  void getUserData() async {
    List<Userinfo> newList = [];

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('UserWeight').get();
    querySnapshot.docs.forEach((element) {
      Userinfo userinfo = Userinfo(
          userWeight: element.get('userWeight'),
          time: element.get('timestamp'));
      newList.add(userinfo);
    });

    userDataList = newList;
    notifyListeners();
  }

  get getuserDataList {
    return userDataList;
  }

//Delteing Cart //
  reviewCartDataDelte(ID) {
    FirebaseFirestore.instance
        .collection('UserWeight')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .delete();
    notifyListeners();
  }

// udating data
  void updateUserInfo({
    String? userWeight,
    Timestamp? time,
  }) async {
    await FirebaseFirestore.instance
        .collection('UserWeight')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(
      {'userWeight': userWeight, 'timestamp': DateTime.now()},
    );
  }
}
