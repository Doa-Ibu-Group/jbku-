import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jbku_project/models/report.dart';

class ReportTile extends StatelessWidget {
  final Report report;
  ReportTile({required this.report});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.00,
            backgroundColor: Colors.amber,
            backgroundImage: AssetImage('assets/person.png'),
          ),
          title: Text('${report.titleOfReport} - ${report.reportCategory}'),
          subtitle: Text(
              '${DateFormat.jm().format(report.dateTime)}- ${report.name}'),
          isThreeLine: true,
        ),
      ),
    );
  }
}
