import 'package:flutter/material.dart';
import 'package:tasks_app/bloc/bloc_exports.dart';
import 'package:tasks_app/core/locator/locator.dart';

import 'package:tasks_app/core/routes/routes.dart';
import 'package:tasks_app/core/routes/routes.manager.dart';
import 'package:tasks_app/models/task_model.dart';
import 'package:go_router/go_router.dart';

class EditTaskView extends StatelessWidget {
  final TaskModel oldTask;
  const EditTaskView({
    Key? key,
    required this.oldTask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController =
        TextEditingController(text: oldTask.title);
    TextEditingController descriptionController =
        TextEditingController(text: oldTask.description);
    return BlocProvider.value(
      value: getIt<TasksBloc>(),
      child: BlocBuilder<TasksBloc, TasksState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                const Text(
                  'Edit Task',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: TextField(
                    autofocus: true,
                    controller: titleController,
                    decoration: const InputDecoration(
                        label: Text('Title'), border: OutlineInputBorder()),
                  ),
                ),
                TextField(
                  autofocus: true,
                  controller: descriptionController,
                  minLines: 3,
                  maxLines: 5,
                  decoration: const InputDecoration(
                      label: Text('Description'), border: OutlineInputBorder()),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: () => context.pop(),
                        child: const Text('Cancel')),
                    ElevatedButton(
                        onPressed: () {
                          var editedTask = TaskModel(
                              date: DateTime.now().toString(),
                              title: titleController.text,
                              isFavorite: oldTask.isFavorite,
                              isDone: false,
                              isDeleted: false,
                              description: descriptionController.text);
                          BlocProvider.of<TasksBloc>(context).add(EditTaskEvent(
                              oldTask: oldTask, newTask: editedTask));
                          router.pop(); // Close the bottom sheet
                          router.go(Routes
                              .main); // Navigate back to the pending tasks page
                        },
                        child: const Text('Save'))
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
