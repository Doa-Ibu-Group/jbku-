import 'package:flutter/material.dart';
import 'package:jbku_project/controller/userAuthentication_controller.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final UserAuthController _auth = UserAuthController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Home Page'), actions: [
        IconButton(
            padding: EdgeInsets.only(right: 40.0),
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () async {
              await _auth.signOut();
            }),
      ]),
    );
  }
}
