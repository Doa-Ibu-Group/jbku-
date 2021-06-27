// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jbku_project/controller/user_controller.dart';
import 'package:jbku_project/models/report.dart';
import 'package:jbku_project/models/user.dart';
import 'package:jbku_project/screens/create_reports/create_report.dart';
import 'package:jbku_project/screens/home/report_list.dart';
import 'package:jbku_project/controller/userAuthentication_controller.dart';
import 'package:jbku_project/controller/report_controller.dart';
import 'package:jbku_project/screens/create_reports/report_page.dart';
import 'package:jbku_project/screens/home/user_setting.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final UserAuthController _auth = UserAuthController();

  @override
  Widget build(BuildContext context) {
    final user =
        Provider.of<User>(context); //cuz we have access the stream user
    return StreamProvider<List<Report>>.value(
      value: ReportController().reports,
      child: Scaffold(
        appBar: AppBar(title: Text('Home'), elevation: 0.0, actions: [
          IconButton(
              padding: EdgeInsets.only(right: 40.0),
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () async {
                await _auth.signOut();
              }),
          IconButton(
              padding: EdgeInsets.only(right: 40.0),
              icon: Icon(
                Icons.verified_user,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return UserSettingPage();
                }));
              }),
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ReportPage();
            }));
          },
          child: const Icon(Icons.navigation),
          backgroundColor: Colors.green,
        ),
        body: ReportList(),
      ),
    );
  }
}
