import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jbku_project/models/report.dart';
import 'package:jbku_project/models/user.dart';
import 'package:provider/provider.dart';

class TrackScreen extends StatelessWidget {
  const TrackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user =
        Provider.of<User>(context); //cuz we have access the stream user
    final reports = Provider.of<List<Report>>(context) ?? [];
    return Scaffold(
      body: ListView.builder(
        itemCount: reports.length,
        itemBuilder: (context, index) {
          reports.sort((a, b) => a.name.compareTo(b.name));
          if (user.uid == reports[index].userId) {
            return Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Card(
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                child: Column(children: [
                  ListTile(
                    title: Text(
                        '#${((index + 1) - reports.length) + 1}. ${reports[index].titleOfReport}'),
                    subtitle: Text(
                        ' ${DateFormat.jm().format(reports[index].dateTime)} | ${reports[index].reportCategory} ',
                        style: TextStyle(color: Colors.black.withOpacity(0.6))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Respond: ${reports[index].respond}',
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                ]),
              ),
            );
          }
          return Container(child: Text(''));
        },
      ),
    );
  }
}
