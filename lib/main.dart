import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_app/app/auth/welcome_screen.dart';
import 'package:tasks_app/blocs/auth_bloc/authentication_bloc.dart';
import 'package:tasks_app/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:tasks_app/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:tasks_app/blocs/tasks_bloc/tasks_bloc.dart';
import 'package:user_repository/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final UserRepository userRepository = FirebaseUserRepo();

  runApp(MyApp(userRepository: userRepository));
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;

  const MyApp({
    Key? key,
    required this.userRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TasksBloc>(
          create: (context) => TasksBloc(),
        ),
        BlocProvider<AuthenticationBloc>(
          create: (context) =>
              AuthenticationBloc(userRepository: userRepository),
        ),
        BlocProvider<SignInBloc>(
          create: (context) => SignInBloc(userRepository: userRepository),
        ),
        BlocProvider<SignUpBloc>(
          create: (context) => SignUpBloc(userRepository: userRepository),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const WelcomeScreen(),
      ),
    );
  }
}
