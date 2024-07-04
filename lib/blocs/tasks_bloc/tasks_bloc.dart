import 'package:equatable/equatable.dart';
import 'package:tasks_app/blocs/bloc_exports.dart';
import 'package:tasks_app/models/task_model.dart';
part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTaskEvent>(_addTask);
    on<UpdateTaskEvent>(_updateTask);
    on<DeleteTaskEvent>(_deleteTask);
    on<FavoriteOrUnfavoriteTaskEvent>(_favoriteOrUnfavoriteTask);
    on<EditTaskEvent>(_editTask);
  }

  void _addTask(AddTaskEvent event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
        pendingTasks: List.from(state.pendingTasks)..add(event.task),
        completedTasks: state.completedTasks,
        favoriteTasks: state.favoriteTasks,
        deletedTasks: state.deletedTasks));
  }

  void _updateTask(UpdateTaskEvent event, Emitter<TasksState> emit) {
    final state = this.state;
    List<TaskModel> pendingTasks = state.pendingTasks;
    List<TaskModel> completedTasks = state.completedTasks;
    event.task.isDone == false
        ? {
            pendingTasks = List.from(pendingTasks)..remove(event.task),
            completedTasks = List.from(completedTasks)
              ..insert(0, event.task.copyWith(isDone: true)),
          }
        : {
            completedTasks = List.from(completedTasks)..remove(event.task),
            pendingTasks = List.from(pendingTasks)
              ..insert(0, event.task.copyWith(isDone: false)),
          };
    emit(TasksState(
      pendingTasks: pendingTasks,
      completedTasks: completedTasks,
      favoriteTasks: state.favoriteTasks,
      deletedTasks: state.deletedTasks,
    ));
  }

  void _deleteTask(DeleteTaskEvent event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
      pendingTasks: List.from(state.pendingTasks)..remove(event.task),
      completedTasks: List.from(state.completedTasks)..remove(event.task),
      favoriteTasks: List.from(state.favoriteTasks)..remove(event.task),
      deletedTasks: List.from(state.deletedTasks)..remove(event.task),
    ));
  }

  void _favoriteOrUnfavoriteTask(
      FavoriteOrUnfavoriteTaskEvent event, Emitter<TasksState> emit) {
    final state = this.state;
    List<TaskModel> favoriteTasks = state.favoriteTasks;
    if (favoriteTasks.contains(event.task)) {
      favoriteTasks = List.from(favoriteTasks)..remove(event.task);
      event.task.isFavorite = false;
    } else {
      favoriteTasks = List.from(favoriteTasks)..add(event.task);
      event.task.isFavorite = true;
    }

    emit(state.copyWith(
      favoriteTasks: favoriteTasks,
    ));
  }

  void _editTask(EditTaskEvent event, Emitter<TasksState> emit) {
    List<TaskModel> pendingTasks = List.from(state.pendingTasks);
    // Update the pending tasks
    if (pendingTasks.contains(event.oldTask)) {
      pendingTasks
        ..remove(event.oldTask)
        ..insert(0, event.newTask);
    }

    // Emit the new state with the updated lists
    emit(TasksState(
        pendingTasks: pendingTasks,
        completedTasks: state.completedTasks,
        favoriteTasks: state.favoriteTasks,
        deletedTasks: state.deletedTasks));
  }
}



/*  void _favoriteOrUnfavoriteTask(
      FavoriteOrUnfavoriteTaskEvent event, Emitter<TasksState> emit) {
    final task = event.task;
    List<TaskModel> pendingTasks = state.pendingTasks;
    List<TaskModel> completedTasks = state.completedTasks;
    List<TaskModel> favoriteTasks = state.favoriteTasks;
    if (event.task.isDone == false) {
      if (event.task.isFavorite == false) {
        var taskIndex = pendingTasks.indexOf(event.task);
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: true));
        favoriteTasks.insert(0, event.task.copyWith(isFavorite: true));
      } else {
        var taskIndex = pendingTasks.indexOf(event.task);
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: false));
        favoriteTasks.remove(event.task);
      }
    } else {
      if (event.task.isFavorite == false) {
        var taskIndex = completedTasks.indexOf(event.task);
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: true));
        favoriteTasks.insert(0, event.task.copyWith(isFavorite: true));
      } else {
        var taskIndex = pendingTasks.indexOf(event.task);
        pendingTasks = List.from(pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: false));
        favoriteTasks.remove(event.task);
      }
    }
    emit(state.copyWith(
      pendingTasks: pendingTasks,
      completedTasks: completedTasks,
      favoriteTasks: state.favoriteTasks,
      removedTasks: state.removedTasks,
    ));
  }*/
