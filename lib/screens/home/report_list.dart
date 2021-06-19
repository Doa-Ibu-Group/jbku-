// @dart=2.9
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jbku_project/models/report.dart';
import 'package:jbku_project/screens/home/create_report.dart';
import 'package:jbku_project/screens/home/report_tile.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';

class ReportList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<ReportList> {
  @override
  Widget build(BuildContext context) {
    final reports = Provider.of<List<Report>>(context) ?? [];

    return ListView.builder(
      itemCount: reports.length,
      itemBuilder: (context, index) {
        return ReportTile(report: reports[index]);
      },
    );
  }
}
