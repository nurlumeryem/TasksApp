import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task_model.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class TaskModel extends Equatable {
  final String title;
  final String description;
  final String date;
  bool? isDone;
  bool? isDeleted;
  bool isFavorite;

  TaskModel(
      {required this.title,
      required this.description,
      required this.date,
      this.isDone,
      this.isDeleted,
      this.isFavorite = false}) {
    isDone = isDone ?? false;
    isDeleted = isDeleted ?? false;
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  @override
  List<Object?> get props =>
      [title, description, date, isDone, isDeleted, isFavorite];
}
