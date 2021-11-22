import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:record_keeping/dynamic/models/department_model.dart';
import 'package:record_keeping/dynamic/models/file_model.dart';
import 'package:record_keeping/dynamic/models/user_model.dart';
import 'package:record_keeping/dynamic/providers/department_provider.dart';
import 'package:record_keeping/dynamic/services/department_service.dart';
import 'package:record_keeping/dynamic/services/file_service.dart';
import 'package:record_keeping/static/utils/constants.dart';

import 'image_capture.dart';

class SendFiles extends StatefulWidget {
  File imageFile;
  User user;
  SendFiles({this.user, this.imageFile});
  @override
  State<StatefulWidget> createState() => _SendFiles();
}

class _SendFiles extends State<SendFiles> {
  final _formKey = GlobalKey<FormState>();

  String name;
  String subject;
  String date;
  int fileNo;

  var _receivers = [
    // 'chairOffice',
    // 'MDOffice',
    // 'Admin/HR',
    // 'Operations',
    'SAR',
    'ANT'
  ];
  var _currentItemSelected = '';

  FileService fileService = FileService();
  DepartmentService departmentService = DepartmentService();

  @override
  void initState() {
    super.initState();
    _currentItemSelected = _receivers[0];
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Colors.brown[100],
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Send files"),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            Consumer<DepartmentProvider>(
                builder: (context, departmentProvider, child) {
              return FlatButton.icon(
                  icon: Icon(Icons.send),
                  label: Text('Send'),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      //IMAGE TO BYTES CONVERSION
                      String base64Image =
                          base64Encode(widget.imageFile.readAsBytesSync());

                      //GETTING DEPARTMENT FROM CONSUMER
                      Department depart =
                          departmentProvider.findByName(_currentItemSelected);
                      print("Department from provider : $depart");

                      Files file = Files(
                          id: fileNo,
                          name: name,
                          subject: subject,
                          date: date,
                          fileBytes: base64Image,
                          departments: [depart]);

                      //POSTING FILE WITH DEPARTMENT
                      bool result = await fileService.postFile(file);
                      if (result) {
                        Fluttertoast.showToast(
                            msg: "Sending",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        Navigator.pop(context);
                      } else {
                        Fluttertoast.showToast(
                            msg: "File not sent",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    } else {
                      Fluttertoast.showToast(
                          msg: "Something is missing",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  });
            }),
          ],
        ),
        body: Consumer<DepartmentProvider>(
          builder: (context, departmentProvider, child) => FutureBuilder(
              future: departmentService.getAllDepartment(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Department> departments = snapshot.data;
                  departmentProvider.departments = departments;

                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: textInputDecoration.copyWith(
                                  hintText: 'Subject'),
                              validator: (val) =>
                                  val.isEmpty ? 'Enter subject' : null,
                              onChanged: (val) {
                                setState(() => subject = val);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: textInputDecoration.copyWith(
                                  hintText: 'name'),
                              validator: (val) =>
                                  val.isEmpty ? 'Enter name' : null,
                              onChanged: (val) {
                                setState(() => name = val);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: textInputDecoration.copyWith(
                                  hintText: 'Date'),
                              validator: (val) =>
                                  val.isEmpty ? 'Enter date' : null,
                              onChanged: (val) {
                                setState(() => date = val);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: textInputDecoration.copyWith(
                                  hintText: 'file no'),
                              validator: (val) =>
                                  val.isEmpty ? 'file no' : null,
                              onChanged: (val) {
                                setState(() => fileNo = int.parse(val));
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Whom",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: DropdownButtonFormField<String>(
                              decoration: textInputDecoration,
                              items: _receivers.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              value: _currentItemSelected,
                              onChanged: (String newValueSelected) {
                                setState(() {
                                  this._currentItemSelected = newValueSelected;
                                });
                              },
                            ),
                          )),
                          widget.imageFile == null
                              ? SizedBox()
                              : Center(
                                  child: Container(
                                    height: 120,
                                    width: 300,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: FileImage(widget.imageFile),
                                            fit: BoxFit.fill)),
                                  ),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 120, bottom: 20),
                            child: RaisedButton(
                              elevation: 10.0,
                              color: Colors.brown[400],
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CameraHome()),
                                );
                              },
                              child: Text(
                                'Capture image',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  print("No data");
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ),
    );
  }
}
