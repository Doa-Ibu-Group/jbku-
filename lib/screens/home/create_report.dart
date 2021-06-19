// @dart=2.9
import 'package:flutter/material.dart';
import 'package:jbku_project/models/user.dart';
import 'package:jbku_project/services/database.dart';
import 'package:jbku_project/share/constant.dart';
import 'package:jbku_project/share/loading.dart';
import 'package:provider/provider.dart';

class CreateReportPage extends StatefulWidget {
  @override
  _CreateReportPageState createState() => _CreateReportPageState();
}

class _CreateReportPageState extends State<CreateReportPage> {
  @override
  final _formKey = GlobalKey<FormState>();

  String _currentName;
  String _currentTitleOfReport;
  String _currentReportCategory = 'potholes';
  String _currentReportDescription;
  Widget build(BuildContext context) {
    final user =
        Provider.of<User>(context); //cuz we have access the stream user

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Report'),
      ),
      body: StreamBuilder<UserData>(
          stream: DatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserData userdata = snapshot.data;
              return Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      initialValue: userdata.name,
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Full Name'),
                      validator: (value) => value.isEmpty ? 'Enter Name' : null,
                      onChanged: (value) {
                        setState(() => _currentName = value);
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      initialValue: userdata.titleOfReport,
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Report Title'),
                      validator: (value) =>
                          value.isEmpty ? 'Enter Report Title' : null,
                      onChanged: (value) {
                        setState(() => _currentTitleOfReport = value);
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      initialValue: userdata.reportDescription,
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Description'),
                      validator: (value) =>
                          value.isEmpty ? 'Enter Report Description' : null,
                      onChanged: (value) {
                        setState(() => _currentReportDescription = value);
                      },
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await DatabaseService(uid: user.uid).updateUserData(
                                _currentName ?? userdata.name,
                                _currentReportCategory ??
                                    userdata.reportCategory,
                                _currentTitleOfReport ?? userdata.titleOfReport,
                                _currentReportDescription ??
                                    userdata.reportDescription);
                            print(_currentName);
                            print(_currentReportCategory);
                            Navigator.pop(context);
                          }
                        },
                        child: Text('Post (update??'))
                  ],
                ),
              );
            } else {
              return Loading();
            }
          }),
    );
  }
}
