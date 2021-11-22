import 'package:flutter/material.dart';
import 'package:record_keeping/dynamic/models/user_model.dart';
import 'package:record_keeping/dynamic/state_management/shared_pref.dart';
import 'package:record_keeping/static/screens/home.dart';
import 'package:record_keeping/static/screens/login.dart';

class Decider extends StatelessWidget {
  SharedPref pref = SharedPref();

  @override
  Widget build(BuildContext context) {
    User user = pref.read("user");
    if (user == null) {
      return Login();
    } else {
      return Home(
        user: user,
      );
    }
  }
}
