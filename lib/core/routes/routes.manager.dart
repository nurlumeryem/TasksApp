import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tasks_app/bloc/bloc_exports.dart';
import 'package:tasks_app/core/locator/locator.dart';
import 'package:tasks_app/core/routes/routes.dart';
import 'package:tasks_app/models/task_model.dart';
import 'package:tasks_app/view/tasks/edit_task_view.dart';

import 'package:tasks_app/view/main/main_view.dart';
import '../../bloc/main_bloc/main_bloc.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: Routes.main,
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
  ],
);
