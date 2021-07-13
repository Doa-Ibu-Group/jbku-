//@dart=2.9
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:uuid/uuid.dart';

class CreatePotholesViewModel extends BaseViewModel {
  var uuid = Uuid();

  String reportId;
  String currentName;
  String currentTitleOfReport;
  String currentReportCategory;
  String currentReportDescription;
  String currentImageUrl;
  String get reportUniqueId => this.reportId = uuid.v1();
  void setName(String n) {
    currentName = n;
    notifyListeners();
  }

  uploadImage() async {
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
        currentImageUrl = downloadUrl;
      } else {
        print('No Path Receive');
      }
    } else {
      print('Grant Permission Unsuccesful Try Again');
    }

    notifyListeners();
  }
}
