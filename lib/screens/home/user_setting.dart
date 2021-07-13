// @dart=2.9
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:jbku_project/controller/user_controller.dart';
import 'package:jbku_project/models/user.dart';
import 'package:jbku_project/share/constant.dart';
import 'package:jbku_project/share/loading.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class UserSettingPage extends StatefulWidget {
  @override
  _UserSettingPageState createState() => _UserSettingPageState();
}

class _UserSettingPageState extends State<UserSettingPage> {
  final _formKey = GlobalKey<FormState>();

  String _currentimageUrl;
  String _currentFullName;
  String _currentLocation;
  String _currentNRIC;
  String _currentUsername;

  @override
  Widget build(BuildContext context) {
    final user =
        Provider.of<User>(context); //cuz we have access the stream user

    return Scaffold(
      body: StreamBuilder<UserInformation>(
          stream: UserController(uid: user.uid).userInformation,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserInformation userinfo = snapshot.data;
              return Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      initialValue: userinfo.fullname,
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Full Name'),
                      validator: (value) => value.isEmpty ? 'Enter Name' : null,
                      onChanged: (value) {
                        setState(() => _currentFullName = value);
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      initialValue: userinfo.location,
                      decoration:
                          textInputDecoration.copyWith(hintText: 'location'),
                      validator: (value) =>
                          value.isEmpty ? 'Enter your location' : null,
                      onChanged: (value) {
                        setState(() => _currentLocation = value);
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      initialValue: userinfo.nric,
                      decoration:
                          textInputDecoration.copyWith(hintText: 'NRIC'),
                      validator: (value) =>
                          value.isEmpty ? 'Enter your NRIC' : null,
                      onChanged: (value) {
                        setState(() => _currentNRIC = value);
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      initialValue: userinfo.username,
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Username'),
                      validator: (value) =>
                          value.isEmpty ? 'your username' : null,
                      onChanged: (value) {
                        setState(() => _currentUsername = value);
                      },
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await UserController(uid: user.uid).addUserInfo(
                                _currentNRIC ?? userinfo.nric,
                                _currentFullName ?? userinfo.fullname,
                                _currentUsername ?? userinfo.username,
                                _currentLocation ?? userinfo.location);

                            print(_currentFullName);
                            print(_currentNRIC);
                            Navigator.pop(context);
                          }
                        },
                        child: Text('UPDATE PROFILE INFO')),
                    SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          await uploadImage();
                          print('succes upload $_currentimageUrl');
                          UserController(uid: user.uid)
                              .addprofilepic(_currentimageUrl);
                          print('succes To FIRESTORE $_currentimageUrl');
                        },
                        child: Text('Update Profile Picture')),
                  ],
                ),
              );
            } else {
              return Loading();
            }
          }),
    );
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
            .child('folderName/$currentdate')
            .putFile(file)
            .onComplete;
        var downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          _currentimageUrl = downloadUrl;
        });
      } else {
        print('No Path Receive');
      }
    } else {
      print('Grant Permission Unsuccesful Try Again');
    }

    //upload to firebase
  }
}
