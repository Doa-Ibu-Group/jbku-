// @dart=2.9
import 'package:flutter/material.dart';
import 'package:jbku_project/models/report.dart';
import 'package:jbku_project/screens/admin/admin_report_tile.dart';
import 'package:provider/provider.dart';

class AdminReportList extends StatefulWidget {
  @override
  _AdminReportListState createState() => _AdminReportListState();
}

class _AdminReportListState extends State<AdminReportList> {
  @override
  Widget build(BuildContext context) {
    final reports = Provider.of<List<Report>>(context) ?? [];
    return ListView.builder(
      itemCount: reports.length,
      itemBuilder: (context, index) {
        /*print(reports[1].userId);
        AdminController(reportuid: reports[1].userId).addRespond(
            'Updated Respond Untuk Report ID ${reports[1].userId} ');*/
        reports.sort((a, b) => b.dateTime.compareTo(a.dateTime));
        return ReportTileAdmin(report: reports[index]);
      },
    );
  }
}
