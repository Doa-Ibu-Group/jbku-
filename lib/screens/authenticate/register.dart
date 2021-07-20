// @dart=2.9
import 'package:flutter/material.dart';
import 'package:jbku_project/backend/controller/userAuthentication_controller.dart';
import 'package:jbku_project/share/constant.dart';
import 'package:jbku_project/share/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final UserAuthController _user = UserAuthController();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String username = '';
  String fullname = '';
  String nric = '';
  String location = '';

  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              title: Text('Register to JBku',
                  style: TextStyle(color: Colors.black87, fontSize: 22.0)),
              actions: [
                IconButton(
                    padding: EdgeInsets.only(right: 40.0),
                    icon: Icon(
                      Icons.login,
                      color: Colors.black87,
                    ),
                    onPressed: () {
                      widget.toggleView();
                    })
              ],
            ),
            body: Container(
                padding:
                    EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.00),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Make Johor a better place',
                          style:
                              TextStyle(color: Colors.black87, fontSize: 18.0),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                            hintText: 'NRIC',
                          ),
                          validator: (value) =>
                              value.isEmpty ? 'Enter NRIC' : null,
                          onChanged: (value) {
                            setState(() {
                              nric = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                            hintText: 'Full Name',
                          ),
                          validator: (value) =>
                              value.isEmpty ? 'Enter Full Name' : null,
                          onChanged: (value) {
                            setState(() {
                              fullname = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                            hintText: 'Email',
                          ),
                          validator: (value) =>
                              value.isEmpty ? 'Enter an Email' : null,
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                            hintText: 'Username',
                          ),
                          validator: (value) =>
                              value.isEmpty ? 'Enter Username' : null,
                          onChanged: (value) {
                            setState(() {
                              username = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                            hintText: 'Location',
                          ),
                          validator: (value) =>
                              value.isEmpty ? 'Enter location' : null,
                          onChanged: (value) {
                            setState(() {
                              location = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Password'),
                          obscureText: true,
                          validator: (value) => value.length < 6
                              ? 'Enter a password more than 6 chars'
                              : null,
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ElevatedButton(
                            child: Text('Register'),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.deepPurple[700],
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 12)),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() => loading = true);
                                dynamic result = await _user.registerWithEmail(
                                    email,
                                    password,
                                    nric,
                                    fullname,
                                    username,
                                    location);
                                if (result == null) {
                                  setState(() {
                                    error = 'Please fill in valid email';
                                    loading = false;
                                  });
                                }
                              }
                            }),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                )),
          );
  }
}
