// @dart=2.9

import 'package:flutter/material.dart';
import 'package:jbku_project/backend/controller/user_controller.dart';
import 'package:jbku_project/backend/models/user.dart';
import 'package:jbku_project/screens/admin/admin_home.dart';
import 'package:jbku_project/screens/authenticate/authenticate.dart';
import 'package:jbku_project/screens/home/home.dart';
import 'package:jbku_project/share/loading.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user =
        Provider.of<User>(context); //cuz we have access the stream user
    print(user);

    if (user == null) {
      return Authenticate();
    } else {
      return StreamBuilder<UserInformation>(
          stream: UserController(uid: user.uid).userInformation,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              if (snapshot.data.role == 'admin') {
                return AdminHome();
              }
              return Home();
            } else {
              return Loading();
            }
          });
    }
  }
}
