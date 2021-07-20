import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jbku_project/backend/models/report.dart';

class ReportTile extends StatelessWidget {
  final Report report;
  ReportTile({required this.report});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: Column(children: [
          Image.network(report.imageUrl),
          ListTile(
            leading: CircleAvatar(
              radius: 25.00,
              backgroundColor: Colors.amber,
              backgroundImage: AssetImage('assets/person.png'),
            ),
            title: Text(' ${report.titleOfReport}'),
            subtitle: Text(
                ' ${DateFormat.jm().format(report.dateTime)} | ${report.name} ',
                style: TextStyle(color: Colors.black.withOpacity(0.6))),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              ' ${report.reportDescription}',
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
        ]),
      ),
    );
  }
}
