// @dart=2.9

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jbku_project/backend/models/report.dart';
import 'package:jbku_project/screens/admin/admin_report_list.dart';
import 'package:jbku_project/backend/controller/userAuthentication_controller.dart';
import 'package:jbku_project/backend/controller/report_controller.dart';
import 'package:provider/provider.dart';

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final UserAuthController _auth = UserAuthController();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Report>>.value(
        value: ReportController().reports,
        child: Scaffold(
          appBar: AppBar(title: Text('Reports'), elevation: 0.0, actions: [
            IconButton(
                padding: EdgeInsets.only(right: 40.0),
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                onPressed: () async {
                  await _auth.signOut();
                }),
          ]),
          body: AdminReportList(),
        ));
  }
}
