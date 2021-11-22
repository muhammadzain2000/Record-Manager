import 'package:json_annotation/json_annotation.dart';

import 'department_model.dart';
part 'file_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Files {
  Files(
      {this.id,
      this.subject,
      this.name,
      this.date,
      this.fileBytes,
      this.departments});

  int id;
  String subject;
  String name;
  String date;
  String fileBytes;
  List<Department> departments;

  factory Files.fromJson(Map<String, dynamic> data) => _$FilesFromJson(data);

  Map<String, dynamic> toJson() => _$FilesToJson(this);
}
