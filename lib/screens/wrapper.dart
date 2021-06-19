// @dart=2.9

import 'package:flutter/material.dart';
import 'package:jbku_project/models/user.dart';
import 'package:jbku_project/screens/authenticate/authenticate.dart';
import 'package:jbku_project/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user =
        Provider.of<User>(context); //cuz we have access the stream user
    print(user);

    if (user == null) {
      //return home or authenticate if not loggin
      return Authenticate();
    } else {
      return Home();
    }
  }
}
