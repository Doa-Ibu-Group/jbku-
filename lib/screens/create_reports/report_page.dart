//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jbku_project/controller/report_controller.dart';
import 'package:jbku_project/controller/user_controller.dart';
import 'package:jbku_project/models/user.dart';
import 'package:jbku_project/screens/create_reports/create_report.dart';
import 'package:jbku_project/screens/create_reports/report_page_ViewModel.dart';
import 'package:jbku_project/share/loading.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => ReportPageViewModel(),
        onModelReady: (model) => null,
        builder: (context, model, child) {
          return StreamBuilder<UserInformation>(
              stream: UserController(uid: user.uid).userInformation,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  UserInformation user = snapshot.data;

                  return Scaffold(
                    body: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(10.0, 20.0, 0, 0),
                            child: Text(
                              'Hi ${user.fullname}, anything happen?',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Image(
                                image: AssetImage('assets/squarenon.png')),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 20.0, 0, 0),
                            child: Text('I want to report a ...?',
                                style: TextStyle(fontSize: 18)),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: DropdownButton(
                                value: model.selectedReportCategory,
                                items: model.generateItem(model.reports),
                                onChanged: (item) {
                                  setState(() {
                                    model.selectedReportCategory = item;
                                  });
                                }),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 40.0),
                              child: ElevatedButton(
                                  onPressed: () async {
                                    switch (model.selectedReportCategory.name) {
                                      case 'Potholes':
                                        DocumentSnapshot snapshot =
                                            await ReportController(
                                                    uid: user.uid)
                                                .getData();
                                        if (snapshot?.data?.isEmpty ?? true) {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return CreatePotholesPage();
                                          }));
                                        } else {
                                          print(snapshot.data['name']);
                                          return showDialog<void>(
                                            context: context,
                                            barrierDismissible:
                                                true, // user must tap button!
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                  title: Text(
                                                      'You Have Active Report'),
                                                  content: Text(
                                                      'Please let Officer do their work '));
                                            },
                                          );
                                        }
                                        break;
                                      case 'Illegal Parking':
                                        print('ILEGAL PARKING');
                                        break;
                                      case 'Suspicious Activity':
                                        print('SUPICIOUS ACTIVITY');
                                        break;
                                      default:
                                        print(
                                            model.selectedReportCategory.name);
                                    }
                                  },
                                  child: Text("Make Report"))),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Loading();
                }
              });
        });
  }
}
