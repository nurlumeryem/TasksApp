import 'package:flutter/material.dart';
import 'package:tasks_app/blocs/bloc_exports.dart';
import 'package:tasks_app/widgets/tasks_list.dart';

import '../models/task_model.dart';

// ignore: must_be_immutable
class PendingTasksScreen extends StatelessWidget {
  const PendingTasksScreen({super.key});
  static const id = 'tasks_screen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<TaskModel> tasksList = state.pendingTasks;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Chip(
                  label: Text(
                      '${tasksList.length} Pending | ${state.completedTasks.length} Completed')),
            ),
            TasksList(tasksList: tasksList)
          ],
        );
      },
    );
  }
}
