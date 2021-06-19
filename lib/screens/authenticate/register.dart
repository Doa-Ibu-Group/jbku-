// @dart=2.9
import 'package:flutter/material.dart';
import 'package:jbku_project/services/auth.dart';
import 'package:jbku_project/share/constant.dart';
import 'package:jbku_project/share/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String name = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.amber,
            appBar: AppBar(
              backgroundColor: Colors.black,
              elevation: 0.0,
              title: Text('Register to JBku'),
              actions: [
                IconButton(
                    padding: EdgeInsets.only(right: 40.0),
                    icon: Icon(
                      Icons.login,
                      color: Colors.white,
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
                  child: Column(
                    children: <Widget>[
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
                            name = value;
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
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Password'),
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
                          child: Text('register'),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);
                              dynamic result = await _auth.registerWithEmail(
                                  email, password);
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
                )),
          );
  }
}
