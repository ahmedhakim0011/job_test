import 'package:flutter/material.dart';
import 'package:job_test/provider/user_Info_provider.dart';
import 'package:provider/provider.dart';

import 'model/userInfo.dart';

class data extends StatefulWidget {
  @override
  State<data> createState() => _dataState();
}

class _dataState extends State<data> {
  @override
  Widget build(BuildContext context) {
    UserInfoProvider userInfoProvider = Provider.of(context);
    userInfoProvider.getuserDataList;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              itemCount: userInfoProvider.getuserDataList.length,
              itemBuilder: ((context, index) {
                Userinfo data = userInfoProvider.getuserDataList[index];

                return Column(
                  children: [Text(data.userWeight.toString())],
                );
              }),
            ),
            Text('data')
          ],
        ),
      ),
    );
  }
}
