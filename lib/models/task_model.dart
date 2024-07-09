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

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
