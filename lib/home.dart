import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_test/model/userInfo.dart';
import 'package:job_test/provider/user_Info_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'authentication_service.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
// 1
  User? user;

  @override
  void initState() {
    setState(() {
      // 2
      user = context.read<AuthenticationService>().getUser();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserInfoProvider userInfoProvider = Provider.of(context);
    userInfoProvider.getUserData();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.indigoAccent,
        title: const Text(
          'Home',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                // 3
                context.read<AuthenticationService>().signOut();
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text("Welcome",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      // 4
                      user != null ? user!.email.toString() : "No User Found",
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: const Text(
                      'User Info',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    )),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: TextFormField(
                    controller: weightController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "please Enter Weight";
                      }
                    },
                    decoration: const InputDecoration(
                        labelText: "Enter Weight",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.red,
                          width: 2.0,
                        ))),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 15.0),
                  child: RaisedButton(
                    child: const Text("Submit"),
                    onPressed: () {
                      userInfoProvider.addUserInfo(
                          userWeight: weightController.text.toString(),
                          ID: FirebaseAuth.instance.currentUser!.uid);
                      weightController.clear();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: userInfoProvider.getuserDataList.length,
                itemBuilder: ((context, index) {
                  Userinfo data = userInfoProvider.getuserDataList[index];
                  print(data.userWeight);

                  return Column(
                    children: [
                      Row(
                        children: [
                          Text(data.userWeight.toString()),
                          Text(data.time.toString()),
                        ],
                      )
                    ],
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
