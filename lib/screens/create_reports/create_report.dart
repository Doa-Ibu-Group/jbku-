// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jbku_project/models/user.dart';
import 'package:jbku_project/controller/report_controller.dart';
import 'package:jbku_project/screens/create_reports/create_report_ViewModel.dart';
import 'package:jbku_project/share/constant.dart';
import 'package:jbku_project/share/loading.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class CreatePotholesPage extends StatefulWidget {
  @override
  _CreatePotholesPageState createState() => _CreatePotholesPageState();
}

class _CreatePotholesPageState extends State<CreatePotholesPage> {
  @override
  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    final user =
        Provider.of<User>(context); //cuz we have access the stream user
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => CreatePotholesViewModel(),
        onModelReady: (model) => null,
        builder: (context, model, child) {
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
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Full Name'),
                      validator: (value) => value.isEmpty ? 'Enter Name' : null,
                      onChanged: (value) {
                        setState(() => model.currentName = value);
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Report Title'),
                      validator: (value) =>
                          value.isEmpty ? 'Enter Report Title' : null,
                      onChanged: (value) {
                        setState(() => model.currentTitleOfReport = value);
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
                        setState(() => model.currentReportDescription = value);
                      },
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            print('current name = ${model.currentName}');
                            print(
                                'current report category${model.currentReportCategory}');
                            await ReportController(uid: user.uid)
                                .addOrUpdateReport(
                                    model.currentName,
                                    model.currentTitleOfReport,
                                    model.currentReportCategory,
                                    model.currentReportDescription);

                            Navigator.popUntil(
                                context, ModalRoute.withName('/'));
                          }
                        },
                        child: Text('Post update'))
                  ],
                ),
              ));
        });
  }
}
