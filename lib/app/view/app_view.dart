import 'package:flutter/material.dart';
import 'package:tasks_app/blocs/auth_bloc/authentication_bloc.dart';
import 'package:tasks_app/blocs/bloc_exports.dart';
import 'package:tasks_app/screens/task_screen/tabs_screen.dart';

import '../auth/welcome_screen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Task App with Firebase Auth',
        theme: ThemeData(
          colorScheme: const ColorScheme.light(
              surface: Colors.white,
              onSurface: Colors.black,
              primary: Color.fromRGBO(206, 147, 216, 1),
              onPrimary: Colors.black,
              secondary: Color.fromRGBO(244, 143, 177, 1),
              onSecondary: Colors.white,
              tertiary: Color.fromRGBO(255, 204, 128, 1),
              error: Colors.red,
              outline: Color(0xFF424242)),
        ),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            return const TabsScreen();
          } else {
            return WelcomeScreen();
          }
        }));
  }
}
