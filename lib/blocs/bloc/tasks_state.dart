part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  final List<TaskModel> pendingTasks;
  final List<TaskModel> completedTasks;
  final List<TaskModel> favoriteTasks;
  final List<TaskModel> deletedTasks;

  const TasksState({
    this.pendingTasks = const <TaskModel>[],
    this.completedTasks = const <TaskModel>[],
    this.favoriteTasks = const <TaskModel>[],
    this.deletedTasks = const <TaskModel>[],
  });

  @override
  List<Object> get props => [
        pendingTasks,
        completedTasks,
        favoriteTasks,
        deletedTasks,
      ];

  TasksState copyWith({
    List<TaskModel>? pendingTasks,
    List<TaskModel>? completedTasks,
    List<TaskModel>? favoriteTasks,
    List<TaskModel>? deletedTasks,
  }) {
    return TasksState(
        pendingTasks: pendingTasks ?? this.pendingTasks,
        completedTasks: completedTasks ?? this.completedTasks,
        favoriteTasks: favoriteTasks ?? this.favoriteTasks,
        deletedTasks: deletedTasks ?? this.deletedTasks);
  }
}
