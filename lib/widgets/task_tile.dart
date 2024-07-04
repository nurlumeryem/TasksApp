import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasks_app/blocs/bloc_exports.dart';
import 'package:tasks_app/models/task_model.dart';
import 'package:tasks_app/screens/task_screen/edit_task_screen.dart';
import 'package:tasks_app/widgets/popup_menu.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    Key? key,
    required this.task,
  }) : super(key: key);

  final TaskModel task;

  void _editTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: EditTaskScreen(oldTask: task),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              task.isFavorite == false
                  ? const Icon(Icons.star_outline)
                  : const Icon(Icons.star),
              const SizedBox(
                width: 10,
              ),
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
        Row(
          children: [
            Checkbox(
              value: task.isDone ?? false,
              onChanged: (value) {
                context.read<TasksBloc>().add(UpdateTaskEvent(task: task));
              },
            ),
          ],
        ),
        PopupMenu(
          task: task,
          cancelOrDeleteCallback: () {
            context.read<TasksBloc>().add(DeleteTaskEvent(task: task));
          },
          likeOrDislikeCallback: () => context
              .read<TasksBloc>()
              .add(FavoriteOrUnfavoriteTaskEvent(task: task)),
          editCallback: () {
            Navigator.of(context).pop();
            _editTask(context);
          },
        ),
      ],
    );
  }
}
