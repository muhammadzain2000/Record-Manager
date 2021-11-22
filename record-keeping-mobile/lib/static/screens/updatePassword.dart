import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:record_keeping/dynamic/models/user_model.dart';
import 'package:record_keeping/dynamic/services/user_service.dart';
import 'package:record_keeping/static/screens/login.dart';
import 'package:record_keeping/static/utils/constants.dart';

class UpdatePassword extends StatefulWidget {
  User user;
  UpdatePassword({this.user});

  @override
  State<StatefulWidget> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  String updatePassword;
  UserService userService = UserService();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: Text("Additional Info"),
        backgroundColor: Colors.brown[400],
      ),
      body: Form(
        key: _formKey,
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration:
                      textInputDecoration.copyWith(hintText: 'password'),
                  validator: (val) =>
                      (val.isEmpty && val.length < 3) ? 'Enter password' : null,
                  onChanged: (val) {
                    setState(() => updatePassword = val);
                  },
                ),
              ),
              RaisedButton(
                elevation: 10.0,
                color: Colors.brown[400],
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    User updatedUser = User(
                        id: widget.user.id,
                        name: widget.user.name,
                        email: widget.user.email,
                        password: updatePassword ?? widget.user.password,
                        department: widget.user.department);
                    bool result = await userService.updateUserById(
                        updatedUser, widget.user.id);
                    if (result) {
                      Navigator.pop(context);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Login()));
                      Fluttertoast.showToast(
                          msg: "Login with your new password",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else {
                      Fluttertoast.showToast(
                          msg: "Not updated",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  }
                },
                child: Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
// else{
//   return Center(child: CircularProgressIndicator());
// }

}
