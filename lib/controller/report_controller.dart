// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jbku_project/models/report.dart';
import 'package:jbku_project/models/user.dart';

class ReportController {
  final String uid;
  ReportController({this.uid});
  //collection reference
  final CollectionReference reportCollection =
      Firestore.instance.collection('reports');

  Future addOrUpdateReport(String id, String name, String titleOfReport,
      String reportCategory, String reportDescription) async {
    return await reportCollection.document(uid).setData({
      'reportID': id,
      'name': name,
      'titleOfReport': titleOfReport,
      'reportCategory': reportCategory,
      'reportDescription': reportDescription,
      'dateTime': DateTime.now(),
      'respond': "",
    });
  }

  Future addRespond(String respond) async {
    return await reportCollection.document(uid).updateData({
      'respond': respond,
    });
  }

  Future addUserAdditionalData(
      String nric, String fullname, String username, String location) async {
    return await reportCollection.document(uid).setData({
      'nric': nric,
      'fullname': fullname,
      'username': username,
      'location': location,
    });
  }

  //reportStreamfrom snapshot
  List<Report> _reportListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Report(
        reportID: doc.data['reportID'] ?? '',
        name: doc.data['name'] ?? '',
        reportCategory: doc.data['reportCategory'] ?? '',
        titleOfReport: doc.data['titleOfReport'] ?? '',
        reportDescription: doc.data['reportDescription'] ?? '',
        dateTime: doc.data['dateTime'].toDate() ?? '',
        respond: doc.data['respond'] ?? '',
      );
    }).toList();
  }

  //get Report stream
  Stream<List<Report>> get reports {
    return reportCollection.snapshots().map((_reportListFromSnapshot));
  }

  Future<DocumentSnapshot> getData() async {
    return await reportCollection.document(uid).get();
  }

  //check if snapshot exist
  Future<bool> get dataIsExists async {
    DocumentSnapshot snapshot = await ReportController().getData();
    if (!snapshot.exists) {
      return true;
    } else {
      return false;
    }
  }
}
