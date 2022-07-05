import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_test/data.dart';
import 'package:job_test/model/userInfo.dart';
import 'package:job_test/provider/user_Info_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'authentication_service.dart';

class Home extends StatefulWidget {
  String? Id;
  Home({this.Id});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController updateWeightController = TextEditingController();

  UserInfoProvider? userInfoProvider;

  Function? onDelete;
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

  showAlertDialog(BuildContext context, Userinfo delete) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Yes"),
      onPressed: () {
        userInfoProvider!.reviewCartDataDelte(delete.docid);

        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete"),
      content: Text("Would you like to delete this weight ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  updateDialog(BuildContext context, update) {
    // set up the buttons
    Widget textfield = Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: TextFormField(
        controller: updateWeightController,
        validator: (value) {
          if (value!.isEmpty) {
            return "please Enter Weight";
          }
        },
        decoration: const InputDecoration(
            labelText: "Enter Weight",
            border: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.blue,
              width: 2.0,
            ))),
      ),
    );

    Widget svaeButton = TextButton(
      child: const Text("Yes"),
      onPressed: () {
        userInfoProvider!.updateUserInfo(
            userWeight: updateWeightController.text, ID: widget.Id);

        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Update"),
      content: const Text("Would you like to update this weight ?"),
      actions: [
        textfield,
        svaeButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    userInfoProvider = Provider.of(context);
    userInfoProvider!.getUserData();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.blue,
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
                          color: Colors.blue,
                          width: 2.0,
                        ))),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 15.0),
                  child: RaisedButton(
                    color: Colors.blue,
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      userInfoProvider!.addUserInfo(
                        userWeight: weightController.text.toString(),
                      );
                      weightController.clear();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: userInfoProvider!.getuserDataList.length,
                itemBuilder: ((context, index) {
                  Userinfo data = userInfoProvider!.getuserDataList[index];
                  print(data.userWeight);

                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                width: 300,
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            5.0) //                 <--- border radius here
                                        )),
                                child: Column(children: [
                                  Row(
                                    children: [
                                      const Text(
                                        'Weight :',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(width: 15),
                                      Text(data.userWeight.toString()),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'Date :',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(width: 15),
                                      Text(data.time!.toDate().toString()),
                                    ],
                                  ),
                                ]),
                              ),
                            ),
                            Container(
                              child: Expanded(
                                flex: 1,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            updateDialog(context, data);
                                          },
                                          icon: const Icon(
                                            Icons.edit,
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            showAlertDialog(context, data);
                                          },
                                          icon: const Icon(Icons.delete,
                                              color: Colors.red))
                                    ]),
                              ),
                            ),
                          ],
                        ),

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Row(
                        //       children: [
                        //         const Text(
                        //           'Weight',
                        //           style: TextStyle(
                        //               fontSize: 15,
                        //               fontWeight: FontWeight.bold),
                        //         ),
                        //         SizedBox(width: 15),
                        //         Text(data.userWeight.toString()),
                        //       ],
                        //     ),
                        //     Row(
                        //       children: [
                        //         const Text(
                        //           'Date',
                        //           style: TextStyle(
                        //               fontSize: 15,
                        //               fontWeight: FontWeight.bold),
                        //         ),
                        //         SizedBox(width: 15),
                        //         Text(data.time!.toDate().toString()),
                        //       ],
                        //     ),
                        //   ],
                        // )
                      ],
                    ),
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
