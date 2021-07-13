// @dart=2.9
import 'package:flutter/material.dart';
import 'package:jbku_project/controller/admin_contoller.dart';
import 'package:jbku_project/controller/report_controller.dart';
import 'package:jbku_project/controller/user_controller.dart';
import 'package:jbku_project/models/report.dart';
import 'package:jbku_project/models/user.dart';
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
    return ListView.builder(
      itemCount: reports.length,
      itemBuilder: (context, index) {
        reports.sort((a, b) => b.dateTime.compareTo(a.dateTime));
        return ReportTile(report: reports[index]);
      },
    );
  }
}
