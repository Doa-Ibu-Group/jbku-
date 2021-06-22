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

  Future addUserReport(String name, String titleOfReport, String reportCategory,
      String reportDescription) async {
    return await reportCollection.document(uid).setData({
      'name': name,
      'titleOfReport': titleOfReport,
      'reportCategory': reportCategory,
      'reportDescription': reportDescription,
      'dateTime': DateTime.now(),
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
          name: doc.data['name'] ?? '',
          reportCategory: doc.data['reportCategory'] ?? '',
          titleOfReport: doc.data['titleOfReport'] ?? '',
          reportDescription: doc.data['reportDescription'] ?? '',
          dateTime: doc.data['dateTime'].toDate() ?? '');
    }).toList();
  }

  //get Report stream
  Stream<List<Report>> get reports {
    return reportCollection.snapshots().map((_reportListFromSnapshot));
  }

  //get User doc Stream
  Stream<UserData> get userData {
    return reportCollection
        .document(uid)
        .snapshots()
        .map((_userDataFromSnapshot));
  }

  //userdata from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data['name'],
        titleOfReport: snapshot.data['titleOfReport'],
        reportDescription: snapshot.data['reportDescription'],
        reportCategory: snapshot.data['reportCategory']);
  }

  //check if snapshot exist
  bool dataIsExists(String uid) {
    reportCollection.document(uid).get();
    DocumentSnapshot task;
  }
}
