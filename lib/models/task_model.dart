import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 1)
class TaskModel extends HiveObject with EquatableMixin {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final String date;
  @HiveField(3)
  bool? isDone;
  @HiveField(4)
  bool isDeleted;
  @HiveField(5)
  bool isFavorite;

  TaskModel({
    required this.title,
    required this.description,
    required this.date,
    this.isDone,
    required this.isDeleted,
    this.isFavorite = false,
  }) {
    isDone = isDone ?? false;
  }

  TaskModel copyWith({
    String? title,
    String? description,
    String? date,
    bool? isDone,
    bool? isDeleted,
    bool? isFavorite,
  }) {
    return TaskModel(
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props =>
      [title, description, date, isDone, isDeleted, isFavorite];
}
