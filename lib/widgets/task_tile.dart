import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasks_app/blocs/bloc_exports.dart';
import 'package:tasks_app/models/task_model.dart';
import 'package:tasks_app/widgets/popup_menu.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    Key? key,
    required this.task,
  }) : super(key: key);

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    void _removeOrDeleteTask(BuildContext context, TaskModel task) {
      context.read<TasksBloc>().add(RemoveOrDeleteTaskEvent(task: task));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              task.isFavorite == false
                  ? const Icon(Icons.star_outline)
                  : const Icon(Icons.star),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 15,
                        decoration: task.isDone ?? false
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    Text(
                      DateFormat()
                          .add_yMMMd()
                          .add_Hms()
                          .format(DateTime.parse(task.date)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Checkbox(
          value: task.isDone ?? false,
          onChanged: (value) {
            context.read<TasksBloc>().add(UpdateTaskEvent(task: task));
          },
        ),
        PopupMenu(
            task: task,
            cancelOrDeleteCallback: () => _removeOrDeleteTask(context, task),
            likeOrDislike: () => context
                .read<TasksBloc>()
                .add(FavoriteOrUnfavoriteTaskEvent(task: task))),
      ],
    );
  }
}
