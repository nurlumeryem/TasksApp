// bloc_locator.dart

import 'package:get_it/get_it.dart';

import 'tasks_bloc/tasks_bloc.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => TasksBloc());
  // Diğer Bloc'ları da buraya kaydedebilirsiniz
}
