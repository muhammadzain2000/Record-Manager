// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Files _$FilesFromJson(Map<String, dynamic> json) {
  return Files(
    id: json['id'] as int,
    subject: json['subject'] as String,
    name: json['name'] as String,
    date: json['date'] as String,
    fileBytes: json['fileBytes'] as String,
    departments: (json['departments'] as List)
        ?.map((e) =>
            e == null ? null : Department.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$FilesToJson(Files instance) => <String, dynamic>{
      'id': instance.id,
      'subject': instance.subject,
      'name': instance.name,
      'date': instance.date,
      'fileBytes': instance.fileBytes,
      'departments': instance.departments?.map((e) => e?.toJson())?.toList(),
    };
