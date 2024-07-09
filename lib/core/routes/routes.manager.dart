import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tasks_app/bloc/bloc_exports.dart';
import 'package:tasks_app/core/locator/locator.dart';
import 'package:tasks_app/core/routes/routes.dart';
import 'package:tasks_app/models/task_model.dart';
import 'package:tasks_app/view/auth/sign_in_view.dart';
import 'package:tasks_app/view/auth/welcome_view.dart';
import 'package:tasks_app/view/main/main_view.dart';
import 'package:tasks_app/view/tasks/edit_task_view.dart'; // Import your signin view

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: Routes.welcome,
      builder: (BuildContext context, GoRouterState state) {
        return const WelcomeView();
      },
    ),
    GoRoute(
      path: Routes.home,
      builder: (BuildContext context, GoRouterState state) {
        return MainView();
      },
    ),
    GoRoute(
      path: Routes.editTask,
      builder: (BuildContext context, GoRouterState state) {
        final oldTask = state.extra as TaskModel;
        return BlocProvider.value(
          value: getIt<TasksBloc>(),
          child: EditTaskView(oldTask: oldTask),
        );
      },
    ),
    GoRoute(
      path: Routes.signIn, // Define your route path for signin screen
      builder: (BuildContext context, GoRouterState state) {
        return const SignInView(); // Replace SignInView with your actual signin screen widget
      },
    ),
  ],
);
