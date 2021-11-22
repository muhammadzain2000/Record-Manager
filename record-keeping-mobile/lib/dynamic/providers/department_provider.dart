import 'package:flutter/cupertino.dart';
import 'package:record_keeping/dynamic/models/department_model.dart';

class DepartmentProvider extends ChangeNotifier {
  List<Department> departments = [];

  //GETTER SETTER
  List<Department> get depart => departments;

  set appoint(List<Department> value) {
    departments = value;
    notifyListeners();
  }

  //METHODS
  Department findByName(String name) {
    for (Department i in departments) {
      if (name == i.name) {
        return i;
      }
    }
  }
}
