import 'package:flutter/material.dart';
import 'package:record_keeping/dynamic/models/user_model.dart';
import 'package:record_keeping/dynamic/services/user_service.dart';
import 'package:record_keeping/dynamic/state_management/shared_pref.dart';
import 'package:record_keeping/static/screens/updatePassword.dart';
import 'package:record_keeping/static/utils/constants.dart';

import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String error = '';

  // text field state
  String email = '';
  String password = '';
  UserService userService = UserService();
  SharedPref pref = SharedPref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: Text('Sign in'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'email'),
                  validator: (val) => val.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  obscureText: true,
                  decoration:
                      textInputDecoration.copyWith(hintText: 'password'),
                  validator: (val) =>
                      val.length < 3 ? 'Enter a password 6+ chars long' : null,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                    color: Colors.pink[400],
                    child: Text(
                      'Sign In',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        //GET USER
                        User newUser = await userService.login(email);
                        if (newUser.password == "123") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdatePassword(
                                  user: newUser,
                                ),
                              ));
                        } else if (newUser.password == password) {
                          //STATE MANAGEMENT WITH SHARED PREF
                          await pref.save("user", newUser);
                          print("User is present");
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Home(
                                  user: newUser,
                                ),
                              ));
                        }
                      }
                    }),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
              ],
            ),
          ),
        ));
  }
}
