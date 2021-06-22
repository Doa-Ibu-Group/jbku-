// @dart=2.9
import 'package:flutter/material.dart';
import 'package:jbku_project/models/user.dart';
import 'package:jbku_project/screens/wrapper.dart';
import 'package:jbku_project/controller/userAuthentication_controller.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: UserAuthController().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
