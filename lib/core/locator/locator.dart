import 'package:get_it/get_it.dart';
import 'package:tasks_app/bloc/bloc_exports.dart';
import 'package:tasks_app/bloc/main_bloc/main_bloc.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerLazySingleton<TasksBloc>(() => TasksBloc());
  getIt.registerLazySingleton<MainBloc>(() => MainBloc());
}
