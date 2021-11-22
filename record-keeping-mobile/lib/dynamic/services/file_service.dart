import 'dart:convert';

import 'package:http/http.dart';
import 'package:record_keeping/dynamic/models/file_model.dart';

import '../../static/utils/constants.dart';

class FileService {
  CustomString api = CustomString();
  //POST file
  Future<bool> postFile(Files file) async {
    var fileJson = jsonEncode(file);
    Response response = await post("${api.endPoint}/file",
        body: fileJson, headers: {"content-type": "application/json"});
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw "can't post file";
    }
  }

  // get a file
  Future<Files> getFileById() async {
    Response response = await get("${api.endPoint}/files",
        headers: {"Content-Type": "application/json"});
    print(response.statusCode);
    print('body: [${response.body}]');
    if (response.body.isNotEmpty) {
      dynamic fileObj = jsonDecode(response.body);
      Files file = Files.fromJson(fileObj);
      print(file);
      return file;
    } else {
      throw "can't get file";
    }
  }

  //GET LIST OF FILE BY DEPARTMENT
  Future<List<Files>> getFilesByDepartmentId(int departmentId) async {
    Response response = await get("${api.endPoint}/getFile/$departmentId",
        headers: {"content-type": "application/json"});
    print(response.statusCode);
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      print(body);
      List<Files> files =
          body.map((dynamic item) => Files.fromJson(item)).toList();
      print(files);
      return files;
    } else {
      throw "Can't get files List";
    }
  }
}
