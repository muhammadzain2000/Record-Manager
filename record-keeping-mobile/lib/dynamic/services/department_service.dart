import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:record_keeping/dynamic/models/department_model.dart';
import 'package:record_keeping/static/utils/constants.dart';

class DepartmentService {
  CustomString api = CustomString();

  //POST DEPARTMENT
  Future postDepartment(Department department) async {
    var fileJson = jsonEncode(department);
    Response response = await post("${api.endPoint}/department",
        body: fileJson, headers: {"content-type": "application/json"});
    print(response.statusCode);
    if (response.statusCode == 200) {
    } else {
      throw "can't post department";
    }
  }

  // GET ALL DEPARTMENT
  Future<List<Department>> getAllDepartment() async {
    var response = await http.get("${api.endPoint}/departments",
        headers: {"content-type": "application/json"});
    print(response.statusCode);
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      print(body);
      List<Department> departments =
          body.map((dynamic item) => Department.fromJson(item)).toList();
      print(departments);
      return departments;
    } else {
      throw "Can't get departments List";
    }
  }
}
