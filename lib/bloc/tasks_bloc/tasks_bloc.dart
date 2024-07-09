import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:tasks_app/bloc/bloc_exports.dart';
import 'package:tasks_app/models/task_model.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final Box<TaskModel> tasksBox = Hive.box<TaskModel>('tasksBox');

  TasksBloc() : super(const TasksState()) {
    on<AddTaskEvent>(_addTask);
    on<CompletedTaskEvent>(_completedTask);
    on<DeleteTaskEvent>(_deleteTask);
    on<FavoriteOrUnfavoriteTaskEvent>(_favoriteOrUnfavoriteTask);
    on<EditTaskEvent>(_editTask);
    on<SearchTaskEvent>(_searchTask);
  }

  void _addTask(AddTaskEvent event, Emitter<TasksState> emit) {
    tasksBox.put(event.task.title, event.task);
    emit(state.copyWith(
        pendingTasks: List.from(state.pendingTasks)..add(event.task),
        completedTasks: state.completedTasks,
        favoriteTasks: state.favoriteTasks,
        deletedTasks: state.deletedTasks));
  }

  void _completedTask(CompletedTaskEvent event, Emitter<TasksState> emit) {
    final state = this.state;
    List<TaskModel> pendingTasks = List.from(state.pendingTasks);
    List<TaskModel> completedTasks = List.from(state.completedTasks);

    if (!event.task.isDone!) {
      pendingTasks.removeWhere((task) => task.title == event.task.title);
      completedTasks.insert(
          0,
          TaskModel(
            title: event.task.title,
            description: event.task.description,
            date: event.task.date,
            isDone: true,
            isDeleted: event.task.isDeleted,
            isFavorite: event.task.isFavorite,
          ));
    } else {
      completedTasks.removeWhere((task) => task.title == event.task.title);
      pendingTasks.insert(
          0,
          TaskModel(
            title: event.task.title,
            description: event.task.description,
            date: event.task.date,
            isDone: false,
            isDeleted: event.task.isDeleted,
            isFavorite: event.task.isFavorite,
          ));
    }
    tasksBox.put(event.task.title, event.task);

    emit(state.copyWith(
      pendingTasks: pendingTasks,
      completedTasks: completedTasks,
      favoriteTasks: state.favoriteTasks,
      deletedTasks: state.deletedTasks,
    ));
  }

  void _deleteTask(DeleteTaskEvent event, Emitter<TasksState> emit) {
    // Hive'dan görevi sil
    tasksBox.delete(event.task.title);

    // Mevcut listelerden görevi sil
    final List<TaskModel> pendingTasks = List.from(state.pendingTasks)
      ..remove(event.task);
    final List<TaskModel> completedTasks = List.from(state.completedTasks)
      ..remove(event.task);
    final List<TaskModel> favoriteTasks = List.from(state.favoriteTasks)
      ..remove(event.task);

    // Yeni durumu emit et
    emit(state.copyWith(
      pendingTasks: pendingTasks,
      completedTasks: completedTasks,
      favoriteTasks: favoriteTasks,
      deletedTasks:
          state.deletedTasks, // deletedTasks listesini güncellemiyoruz
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
    tasksBox.put(event.task.title, event.task);
    emit(state.copyWith(
      favoriteTasks: favoriteTasks,
    ));
  }

  void _editTask(EditTaskEvent event, Emitter<TasksState> emit) {
    final newTask = event.newTask;
    final oldTask = event.oldTask;
    tasksBox.put(oldTask.title, newTask);

    List<TaskModel> pendingTasks = List.from(state.pendingTasks);
    if (pendingTasks.contains(oldTask)) {
      pendingTasks
        ..remove(oldTask)
        ..insert(0, newTask);
    }

    List<TaskModel> completedTasks = List.from(state.completedTasks);
    if (completedTasks.contains(oldTask)) {
      completedTasks
        ..remove(oldTask)
        ..insert(0, newTask);
    }

    List<TaskModel> favoriteTasks = List.from(state.favoriteTasks);
    if (oldTask.isFavorite == true) {
      favoriteTasks
        ..remove(oldTask)
        ..insert(0, newTask);
    }

    emit(state.copyWith(
      pendingTasks: pendingTasks,
      completedTasks: completedTasks,
      favoriteTasks: favoriteTasks,
      deletedTasks: state.deletedTasks,
    ));
  }

  void _searchTask(SearchTaskEvent event, Emitter<TasksState> emit) {
    final state = this.state;
    List<TaskModel> searchResults = state.pendingTasks
        .where((task) =>
            task.title.toLowerCase().contains(event.query.toLowerCase()))
        .toList();

    emit(state.copyWith(searchResults: searchResults));
  }
}
