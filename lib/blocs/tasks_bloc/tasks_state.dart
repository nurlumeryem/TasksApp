part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  final List<TaskModel> pendingTasks;
  final List<TaskModel> completedTasks;
  final List<TaskModel> favoriteTasks;
  final List<TaskModel> deletedTasks;
  final List<TaskModel> searchResultsTask;

  const TasksState({
    this.pendingTasks = const <TaskModel>[],
    this.completedTasks = const <TaskModel>[],
    this.favoriteTasks = const <TaskModel>[],
    this.deletedTasks = const <TaskModel>[],
    this.searchResultsTask = const <TaskModel>[],
  });

  @override
  List<Object> get props => [
        pendingTasks,
        completedTasks,
        favoriteTasks,
        deletedTasks,
        searchResultsTask,
      ];

  TasksState copyWith({
    List<TaskModel>? pendingTasks,
    List<TaskModel>? completedTasks,
    List<TaskModel>? favoriteTasks,
    List<TaskModel>? deletedTasks,
    List<TaskModel>? searchResultsTask,
  }) {
    return TasksState(
        pendingTasks: pendingTasks ?? this.pendingTasks,
        completedTasks: completedTasks ?? this.completedTasks,
        favoriteTasks: favoriteTasks ?? this.favoriteTasks,
        deletedTasks: deletedTasks ?? this.deletedTasks,
        searchResultsTask: searchResultsTask ?? this.searchResultsTask);
  }
}
