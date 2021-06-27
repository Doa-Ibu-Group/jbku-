// @dart=2.9
import 'package:flutter/material.dart';
import 'package:jbku_project/controller/userAuthentication_controller.dart';
import 'package:jbku_project/share/constant.dart';
import 'package:jbku_project/share/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final UserAuthController _auth = UserAuthController();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
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
              title: Text('SIGN IN'),
              actions: [
                IconButton(
                    padding: EdgeInsets.only(right: 40.0),
                    icon: Icon(
                      Icons.app_registration,
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
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
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
                        validator: (value) =>
                            value.isEmpty ? 'Please Enter a Password' : null,
                        obscureText: true,
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
                          child: Text('Sign in'),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);
                              dynamic result =
                                  await _auth.signIn(email, password);
                              result != null ? print(result.uid) : null;
                              if (result == null) {
                                setState(() {
                                  error =
                                      "Sorry, we couldn't find an account with that username or password";
                                  loading = false;
                                });
                              }
                            }
                          }),
                      ElevatedButton(
                        child: Text('Sign in Anon Test'),
                        onPressed: () async {
                          dynamic result = await _auth
                              .signInAnon(); //dynamic cuz could be null
                          if (result == null) {
                            print('error sign in anon');
                          } else {
                            print('signed in ');
                            print(result.uid);
                          }
                        },
                      ),
                      SizedBox(
                        height: 12.0,
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
