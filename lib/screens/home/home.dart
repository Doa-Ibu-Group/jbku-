import 'package:flutter/material.dart';
import 'package:jbku_project/models/report.dart';
import 'package:jbku_project/screens/home/create_report.dart';
import 'package:jbku_project/screens/home/report_list.dart';
import 'package:jbku_project/services/auth.dart';
import 'package:jbku_project/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Report>>.value(
      value: DatabaseService().reports,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          elevation: 0.0,
          actions: [
            IconButton(
                padding: EdgeInsets.only(right: 40.0),
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                onPressed: () async {
                  await _auth.signOut();
                }),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CreateReportPage();
                  }));
                },
                child: Text("Make Report"))
          ],
        ),
        body: ReportList(),
      ),
    );
  }
}
