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
    on<SearchTaskEvent>(_searchTask);
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
    List<TaskModel> pendingTasks = List.from(state.pendingTasks);
    List<TaskModel> completedTasks = List.from(state.completedTasks);

    // Eğer görev tamamlanmamışsa
    if (!event.task.isDone!) {
      // Önce bu görevi pendingTasks listesinden kaldırın
      pendingTasks.removeWhere((task) => task.title == event.task.title);
      // Sonra completedTasks listesine ekle, isDone true olarak ayarlanmış şekilde
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
      // Eğer görev tamamlanmışsa
      // Önce bu görevi completedTasks listesinden kaldırın
      completedTasks.removeWhere((task) => task.title == event.task.title);
      // Sonra pendingTasks listesine ekle, isDone false olarak ayarlanmış şekilde
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

  void _searchTask(SearchTaskEvent event, Emitter<TasksState> emit) {
    final state = this.state;

    // Önce tüm görevleri kopyalayın
    List<TaskModel> pendingTasks = List.from(state.pendingTasks);
    List<TaskModel> completedTasks = List.from(state.completedTasks);

    // Pending task'leri arayın ve filtreleyin
    List<TaskModel> filteredPendingTasks = pendingTasks.where((task) {
      return task.title.toLowerCase().contains(event.task.toLowerCase());
    }).toList();

    // Completed task'leri arayın ve filtreleyin
    List<TaskModel> filteredCompletedTasks = completedTasks.where((task) {
      return task.title.toLowerCase().contains(event.task.toLowerCase());
    }).toList();

    // Yeni bir TasksState oluşturarak emit edin
    emit(
      state.copyWith(
        pendingTasks: filteredPendingTasks,
        completedTasks: filteredCompletedTasks,
      ),
    );
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
