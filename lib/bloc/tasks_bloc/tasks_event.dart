part of 'tasks_bloc.dart';

sealed class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

class AddTaskEvent extends TasksEvent {
  final TaskModel task;
  const AddTaskEvent({
    required this.task,
  });

  @override
  List<Object> get props => [task];
}

class CompletedTaskEvent extends TasksEvent {
  final TaskModel task;
  const CompletedTaskEvent({
    required this.task,
  });

  @override
  List<Object> get props => [task];
}

class DeleteTaskEvent extends TasksEvent {
  final TaskModel task;
  const DeleteTaskEvent({
    required this.task,
  });

  @override
  List<Object> get props => [task];
}

class FavoriteOrUnfavoriteTaskEvent extends TasksEvent {
  final TaskModel task;
  const FavoriteOrUnfavoriteTaskEvent({required this.task});
  @override
  List<Object> get props => [task];
}

class EditTaskEvent extends TasksEvent {
  final TaskModel oldTask;
  final TaskModel newTask;
  const EditTaskEvent({
    required this.oldTask,
    required this.newTask,
  });
  @override
  List<Object> get props => [oldTask, newTask];
}

class SearchTaskEvent extends TasksEvent {
  final String query;

  const SearchTaskEvent(this.query);

  @override
  List<Object> get props => [query];
}

class LoadTasksEvent extends TasksEvent {}
