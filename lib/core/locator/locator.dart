import 'package:get_it/get_it.dart';
import 'package:tasks_app/auth/firebase_user_repo.dart';
import 'package:tasks_app/auth/user_repo.dart';
import 'package:tasks_app/bloc/tasks_bloc/tasks_bloc.dart';
import 'package:tasks_app/bloc/main_bloc/main_bloc.dart';
import 'package:tasks_app/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:tasks_app/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:tasks_app/bloc/authentication_bloc/authentication_bloc.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // Repositories
  getIt.registerLazySingleton<UserRepository>(() => FirebaseUserRepo());

  // Blocs
  getIt.registerLazySingleton<TasksBloc>(() => TasksBloc());
  getIt.registerLazySingleton<MainBloc>(() => MainBloc());
  getIt.registerLazySingleton<AuthenticationBloc>(
      () => AuthenticationBloc(userRepository: getIt<UserRepository>()));
  getIt.registerLazySingleton<SignInBloc>(() => SignInBloc());
  getIt.registerLazySingleton<SignUpBloc>(() => SignUpBloc());
}
