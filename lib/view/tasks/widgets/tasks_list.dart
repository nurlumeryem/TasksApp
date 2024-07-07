import 'package:flutter/material.dart';
import 'package:tasks_app/models/task_model.dart';
import 'package:tasks_app/view/tasks/widgets/task_tile.dart';

class TasksList extends StatelessWidget {
  const TasksList({
    super.key,
    required this.tasksList,
  });

  final List<TaskModel> tasksList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
          child: ExpansionPanelList.radio(
              children: tasksList
                  .map(
                    (task) => ExpansionPanelRadio(
                        headerBuilder: (context, isOpen) =>
                            TaskTile(task: task),
                        body: ListTile(
                          title: SelectableText.rich(TextSpan(children: [
                            const TextSpan(
                                text: 'Text\n',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                            TextSpan(text: task.title),
                            const TextSpan(
                                text: '\n\nDescription\n',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: task.description)
                          ])),
                        ),
                        value: UniqueKey()),
                  )
                  .toList())),
    );
  }
}
