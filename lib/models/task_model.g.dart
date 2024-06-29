// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) => TaskModel(
      title: json['title'] as String,
      date: json['date'] as String,
      isDone: json['isDone'] as bool?,
      isDeleted: json['isDeleted'] as bool?,
      description: json['descripton'] as String,
      isFavorite: json['isFavorite'] as bool?,
    );

Map<String, dynamic> _$TaskModelToJson(TaskModel instance) => <String, dynamic>{
      'title': instance.title,
      'isDone': instance.isDone,
      'isDeleted': instance.isDeleted,
    };
