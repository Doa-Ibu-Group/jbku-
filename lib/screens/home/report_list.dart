// @dart=2.9
import 'package:flutter/material.dart';
import 'package:jbku_project/backend/models/report.dart';
import 'package:jbku_project/screens/home/report_tile.dart';
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
