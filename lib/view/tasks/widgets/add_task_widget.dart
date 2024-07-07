import 'package:flutter/material.dart';
import 'package:tasks_app/bloc/bloc_exports.dart';
import 'package:tasks_app/core/routes/routes.manager.dart';
import '../../../models/task_model.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          const Text(
            'Add Task',
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
                  onPressed: () => router.pop(context),
                  child: const Text('Cancel')),
              ElevatedButton(
                  onPressed: () {
                    var task = TaskModel(
                        isDeleted: false,
                        date: DateTime.now().toString(),
                        title: titleController.text,
                        description: descriptionController.text);
                    context.read<TasksBloc>().add(AddTaskEvent(task: task));
                    router.pop(context);
                  },
                  child: const Text('Add'))
            ],
          ),
        ],
      ),
    );
  }
}
