import 'package:flutter/material.dart';
import 'package:tasks_app/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:tasks_app/bloc/bloc_exports.dart';
import 'package:tasks_app/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:tasks_app/view/auth/welcome_view.dart';
import 'package:tasks_app/view/main/main_view.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth',
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
          outline: Color(0xFF424242),
        ),
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            return BlocProvider(
              create: (context) => SignInBloc(),
              child: MainView(),
            );
          } else {
            return const WelcomeView();
          }
        },
      ),
    );
  }
}
