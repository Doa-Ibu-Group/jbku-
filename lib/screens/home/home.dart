// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jbku_project/controller/user_controller.dart';
import 'package:jbku_project/models/report.dart';
import 'package:jbku_project/models/user.dart';
import 'package:jbku_project/screens/create_reports/create_report.dart';
import 'package:jbku_project/screens/home/home_viewmodel.dart';
import 'package:jbku_project/screens/home/report_list.dart';
import 'package:jbku_project/controller/userAuthentication_controller.dart';
import 'package:jbku_project/controller/report_controller.dart';
import 'package:jbku_project/screens/create_reports/report_page.dart';
import 'package:jbku_project/screens/home/user_setting.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final UserAuthController _auth = UserAuthController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => HomeViewModel(),
        onModelReady: (model) => null,
        builder: (context, model, child) {
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
              ]),
              body: model.widgetOptions[model.selectedIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: model.selectedIndex,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.purple[200],
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Timeline',
                      backgroundColor: Colors.white),
                  BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.doc_plaintext),
                      label: 'Report'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.source_outlined), label: 'Track'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: 'Profile')
                ],
                onTap: (index) {
                  setState(() {
                    model.selectedIndex = index;
                  });
                },
              ),
            ),
          );
        });
  }
}
