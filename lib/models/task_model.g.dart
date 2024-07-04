// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) => TaskModel(
      title: json['title'] as String,
      description: json['description'] as String,
      date: json['date'] as String,
      isDone: json['isDone'] as bool?,
      isDeleted: json['isDeleted'] as bool?,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );

Map<String, dynamic> _$TaskModelToJson(TaskModel instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'date': instance.date,
      'isDone': instance.isDone,
      'isDeleted': instance.isDeleted,
      'isFavorite': instance.isFavorite,
    };
