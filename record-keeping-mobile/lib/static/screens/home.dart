import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:record_keeping/dynamic/providers/user_provider.dart';
import 'package:record_keeping/dynamic/state_management/shared_pref.dart';

import 'package:record_keeping/static/screens/login.dart';
import 'package:record_keeping/static/screens/recieved_files.dart';

import 'package:record_keeping/static/screens/send_files.dart';

import '../../dynamic/models/user_model.dart';
import '../../dynamic/services/user_service.dart';

class Home extends StatelessWidget {
  User user;

  Home({this.user});

  UserService userService = UserService();
  SharedPref pref = SharedPref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Dashboard'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            Consumer<UserProvider>(
              builder: (context, userProvider, child) => FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text('logout'),
                onPressed: () async {
                  await pref.save("user", null);
                  userProvider.users = null;
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
              ),
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Text(user.name),
            SizedBox(
              height: 10,
            ),
            Text(user.department.name),
            SizedBox(
              height: 15,
            ),
            RaisedButton(
              elevation: 10.0,
              color: Colors.brown[400],
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReceivedFiles(
                            departmentName: user.department.name,
                          )),
                );
              },
              child: Text(
                'Received files',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            RaisedButton(
              elevation: 10.0,
              color: Colors.brown[400],
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SendFiles(imageFile: null, user: user)),
                );
              },
              child: Text(
                'Send files',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ));
  }
}
