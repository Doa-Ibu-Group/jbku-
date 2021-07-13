import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jbku_project/controller/admin_contoller.dart';
import 'package:jbku_project/models/report.dart';
import 'package:jbku_project/screens/admin/admin_respond_report.dart';

class ReportTileAdmin extends StatelessWidget {
  final Report report;
  ReportTileAdmin({required this.report});
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
            title: Text(' ${report.titleOfReport}'),
            subtitle: Text(
                ' ${DateFormat.jm().format(report.dateTime)} | ${report.name} ',
                style: TextStyle(color: Colors.black.withOpacity(0.6))),
          ),
          Row(children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                ' ${report.reportDescription}',
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
          ]),
          Row(
            children: [
              ButtonBar(
                alignment: MainAxisAlignment.start,
                children: [
                  OutlinedButton(
                    onPressed: () async {
                      await AdminController(reportuid: report.userId).delete();
                    },
                    child: const Text(
                      'Close Case',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Respond(
                          imgUrl: report.imageUrl,
                          userid: report.userId,
                          respond: report.respond,
                          reportCategory: report.reportCategory,
                          reportDescription: report.reportDescription,
                          reportTitle: report.titleOfReport,
                          reportdateTime: report.dateTime.toString(),
                          reportid: report.reportID,
                        );
                      }));
                    },
                    child: const Text('Respond'),
                  ),
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
