// @dart=2.9
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jbku_project/controller/user_controller.dart';
import 'package:jbku_project/models/report.dart';
import 'package:jbku_project/models/user.dart';
import 'package:jbku_project/screens/home/create_report.dart';
import 'package:jbku_project/screens/home/report_tile.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';

class ReportList extends StatefulWidget {
  @override
  _ReportListState createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {
  @override
  Widget build(BuildContext context) {
    final reports = Provider.of<List<Report>>(context) ?? [];
    final user =
        Provider.of<User>(context); //cuz we have access the stream user
    return StreamBuilder<UserInformation>(
        stream: UserController(uid: user.uid).userInformation,
        builder: (context, snapshot) {
          return Column(
            children: <Widget>[
              Text('Hi, ${snapshot.data.fullname}',
                  style: DefaultTextStyle.of(context)
                      .style
                      .apply(fontSizeFactor: 2.0)),
              Expanded(
                child: ListView.builder(
                  itemCount: reports.length,
                  itemBuilder: (context, index) {
                    reports.sort((a, b) => a.name.compareTo(b.name));
                    return ReportTile(report: reports[index]);
                  },
                ),
              ),
            ],
          );
        });
  }
}
