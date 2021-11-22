import 'package:json_annotation/json_annotation.dart';

part 'department_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Department {
  Department({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Department.fromJson(Map<String, dynamic> data) =>
      _$DepartmentFromJson(data);

  Map<String, dynamic> toJson() => _$DepartmentToJson(this);
}
