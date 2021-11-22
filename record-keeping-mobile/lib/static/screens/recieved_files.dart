import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:record_keeping/dynamic/models/file_model.dart';
import 'package:record_keeping/dynamic/providers/department_provider.dart';
import 'package:record_keeping/dynamic/services/department_service.dart';
import 'package:record_keeping/dynamic/models/department_model.dart';
import 'package:record_keeping/dynamic/services/file_service.dart';
import 'package:record_keeping/static/widgets/file_card.dart';

class ReceivedFiles extends StatefulWidget {
  String departmentName;
  ReceivedFiles({this.departmentName});
  @override
  State<StatefulWidget> createState() {
    return ReceivedFilesState();
  }
}

class ReceivedFilesState extends State<ReceivedFiles> {
  List<Files> fileList;
  int count = 0;
  DepartmentService departmentService = DepartmentService();
  FileService fileService = FileService();

  @override
  Widget build(BuildContext context) {
    return Consumer<DepartmentProvider>(
      builder: (context, departmentProvider, child) {
        return FutureBuilder(
            future: departmentService.getAllDepartment(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Department> departments = snapshot.data;
                departmentProvider.departments = departments;
                //GET DEPARTMENT
                Department depart =
                    departmentProvider.findByName(widget.departmentName);
                return FutureBuilder(
                    future: fileService.getFilesByDepartmentId(depart.id),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Files> files = snapshot.data;
                        return Scaffold(
                            appBar: AppBar(
                              title: Text("recieved files"),
                            ),
                            body: ListView.builder(
                                itemCount: files.length,
                                itemBuilder: (context, i) {
                                  return FileCard(
                                    file: files[i],
                                  );
                                }));
                      } else {
                        print("No data");
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    });
              } else {
                print("No data");
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            });
      },
    );
  }
}
// }
