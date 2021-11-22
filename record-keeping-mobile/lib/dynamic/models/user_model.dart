import 'package:json_annotation/json_annotation.dart';

import 'department_model.dart';
part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.department,
  });

  String id;
  String name;
  String email;
  dynamic password;
  Department department;

  factory User.fromJson(Map<String, dynamic> data) => _$UserFromJson(data);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
