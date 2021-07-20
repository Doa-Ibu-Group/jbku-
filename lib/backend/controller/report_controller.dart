// @dart=2.9
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:jbku_project/backend/models/report.dart';
import 'package:jbku_project/backend/models/user.dart';
import 'package:permission_handler/permission_handler.dart';

class ReportController {
  final String uid;
  ReportController({this.uid});
  //collection reference
  final CollectionReference reportCollection =
      Firestore.instance.collection('reports');

  Future addOrUpdateReport(String id, String name, String titleOfReport,
      String reportCategory, String reportDescription, String imageUrl) async {
    return await reportCollection.document(uid).setData({
      'reportID': id,
      'userId': uid,
      'name': name,
      'titleOfReport': titleOfReport,
      'reportCategory': reportCategory,
      'reportDescription': reportDescription,
      'imageUrl': imageUrl,
      'dateTime': DateTime.now(),
      'respond': "your report is still being handled",
    });
  }

  Future addRespond(String reportUid, String respond) async {
    return await reportCollection.document(reportUid).updateData({
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
          userId: doc.data['userId'] ?? '',
          reportID: doc.data['reportID'] ?? '',
          name: doc.data['name'] ?? '',
          reportCategory: doc.data['reportCategory'] ?? '',
          titleOfReport: doc.data['titleOfReport'] ?? '',
          reportDescription: doc.data['reportDescription'] ?? '',
          dateTime: doc.data['dateTime'].toDate() ?? '',
          respond: doc.data['respond'] ?? '',
          imageUrl: doc.data['imageUrl'] ?? '');
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

  Future<String> uploadImage() async {
    DateTime now = new DateTime.now();
    var datestamp = new DateFormat("yyyyMMdd'T'HHmmss");
    String currentdate = datestamp.format(now);
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;
    //check permission
    await Permission.photos.request();
    var permissionstatus = await Permission.photos.status;
    if (permissionstatus.isGranted) {
      //select image
      image = await _picker.getImage(source: ImageSource.gallery);
      var file = File(image.path);
      if (image != null) {
        var snapshot = await _storage
            .ref()
            .child('Report/$currentdate')
            .putFile(file)
            .onComplete;
        var downloadUrl = await snapshot.ref.getDownloadURL();
        return downloadUrl;
      } else {
        print('No Path Receive');
        return null;
      }
    } else {
      print('Grant Permission Unsuccesful Try Again');
      return null;
    }

    //upload to firebase
  }
}
