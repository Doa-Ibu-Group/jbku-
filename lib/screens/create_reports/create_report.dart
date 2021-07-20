// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jbku_project/backend/models/user.dart';
import 'package:jbku_project/backend/controller/report_controller.dart';
import 'package:jbku_project/screens/create_reports/create_report_ViewModel.dart';
import 'package:jbku_project/share/constant.dart';
import 'package:jbku_project/share/loading.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class CreateReport extends StatefulWidget {
  final String category;
  CreateReport({this.category});
  @override
  _CreateReportState createState() => _CreateReportState();
}

class _CreateReportState extends State<CreateReport> {
  @override
  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    //cuz we have access the stream user
    return Scaffold(
        appBar: AppBar(),
        body: ViewModelBuilder.reactive(
            viewModelBuilder: () => CreatePotholesViewModel(),
            onModelReady: (model) => null,
            builder: (context, model, child) {
              return Form(
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
                          value.isEmpty ? 'Enter Report Description ' : null,
                      onChanged: (value) {
                        setState(() => model.currentReportDescription = value);
                      },
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      children: <Widget>[
                        ElevatedButton(
                            onPressed: () async {
                              await model.uploadImage();
                              setState(() {});
                            },
                            child: Text('Upload Image')),
                        Text(
                            '    ${model.currentImageUrl ?? model.currentImageUrl}')
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await ReportController(uid: user.uid)
                                .addOrUpdateReport(
                                    model.reportUniqueId,
                                    model.currentName,
                                    model.currentTitleOfReport,
                                    widget.category,
                                    model.currentReportDescription,
                                    model.currentImageUrl);

                            Navigator.popUntil(
                                context, ModalRoute.withName('/'));
                          }
                        },
                        child: Text('Post update'))
                  ],
                ),
              );
            }));
  }
}
