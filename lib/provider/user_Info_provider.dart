import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:job_test/model/userInfo.dart';
import 'package:provider/provider.dart';

class UserInfoProvider with ChangeNotifier {
  void addUserInfo({
    String? ID,
    String? userWeight,
    Timestamp? time,
  }) async {
    await FirebaseFirestore.instance
        .collection('UserWeight')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('YourWight')
        .doc(ID)
        .set({
      'userID': ID,
      'userWeight': userWeight,
      'timeStamp': Timestamp.now()
    });
  }

  List<Userinfo> userDataList = [];
  void getUserData() async {
    List<Userinfo> newList = [];

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('UserWeight')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('YourWight')
        .get();
    querySnapshot.docs.forEach((element) {
      Userinfo userinfo = Userinfo(
          Id: element.get('userID'),
          userWeight: element.get('userWeight'),
          time: element.get('timeStamp'));
      newList.add(userinfo);
    });

    userDataList = newList;
    notifyListeners();
  }

  get getuserDataList {
    return userDataList;
  }

//Delteing Cart //
  reviewCartDataDelte(userID) {
    FirebaseFirestore.instance
        .collection('ReviewCartData')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('YourReviewCart')
        .doc(userID)
        .delete();
    notifyListeners();
  }

// udating data
  void updateUserInfo({
    String? ID,
    String? userWeight,
  }) async {
    await FirebaseFirestore.instance
        .collection('UserWeight')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('YourWight')
        .doc(ID)
        .update({
      'userWeight': userWeight,
    });
  }
}
