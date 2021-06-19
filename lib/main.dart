// @dart=2.9
import 'package:flutter/material.dart';
import 'package:jbku_project/models/user.dart';
import 'package:jbku_project/screens/wrapper.dart';
import 'package:jbku_project/services/auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
