import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:record_keeping/dynamic/state_management/decider.dart';
import 'package:record_keeping/static/screens/login.dart';
import 'dynamic/providers/department_provider.dart';
import 'dynamic/providers/user_provider.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
            create: (context) => UserProvider()),
        ChangeNotifierProvider<DepartmentProvider>(
            create: (context) => DepartmentProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Login(),
      ),
    );
  }
}
