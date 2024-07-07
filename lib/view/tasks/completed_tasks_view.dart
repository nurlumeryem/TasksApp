import 'package:flutter/material.dart';
import 'package:tasks_app/bloc/bloc_exports.dart';
import 'package:tasks_app/view/tasks/widgets/tasks_list.dart';

import '../../models/task_model.dart';

// ignore: must_be_immutable
class CompletedTasksScreen extends StatelessWidget {
  const CompletedTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<TaskModel> tasksList = state.completedTasks;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurpleAccent,
            centerTitle: true,
            title: const Text(
              'Completed Tasks',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Center(
                  child: Chip(
                      label: Text(
                    '${tasksList.length} Tasks',
                    style: const TextStyle(fontSize: 22),
                  )),
                ),
              ),
              TasksList(tasksList: tasksList)
            ],
          ),
        );
      },
    );
  }
}
