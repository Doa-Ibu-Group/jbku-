// @dart=2.9
import 'package:flutter/material.dart';
import 'package:jbku_project/models/user.dart';
import 'package:jbku_project/controller/report_controller.dart';
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
        body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Full Name'),
                validator: (value) => value.isEmpty ? 'Enter Name' : null,
                onChanged: (value) {
                  setState(() => _currentName = value);
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration:
                    textInputDecoration.copyWith(hintText: 'Report Title'),
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
                      await ReportController(uid: user.uid).addUserReport(
                          _currentName,
                          _currentTitleOfReport,
                          _currentReportCategory,
                          _currentReportDescription);
                      print(_currentName);
                      print(_currentReportCategory);
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Post (update??'))
            ],
          ),
        ));
  }
}
