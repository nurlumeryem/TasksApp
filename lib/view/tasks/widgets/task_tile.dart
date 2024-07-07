import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasks_app/bloc/bloc_exports.dart';
import 'package:tasks_app/core/routes/routes.manager.dart';
import 'package:tasks_app/models/task_model.dart';
import 'package:tasks_app/view/tasks/edit_task_view.dart';
import 'package:tasks_app/view/tasks/widgets/popup_menu.dart';

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
                child: EditTaskView(oldTask: task),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                task.isFavorite == false
                    ? const Icon(Icons.star_outline)
                    : const Icon(Icons.star, color: Colors.orange),
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
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurpleAccent,
                          decoration: task.isDone ?? false
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      Text(
                        DateFormat()
                            .add_yMMMd()
                            .add_Hms()
                            .format(DateTime.now()),
                        style: const TextStyle(
                          color: Colors.deepPurpleAccent,
                          fontWeight: FontWeight.bold,
                        ),
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
                  context.read<TasksBloc>().add(CompletedTaskEvent(task: task));
                },
                activeColor: Colors.deepPurpleAccent,
              ),
            ],
          ),
          PopupMenu(
            task: task,
            deleteCallback: () {
              context.read<TasksBloc>().add(DeleteTaskEvent(task: task));
            },
            likeOrDislikeCallback: () => context
                .read<TasksBloc>()
                .add(FavoriteOrUnfavoriteTaskEvent(task: task)),
            editCallback: () {
              router.pop();
              _editTask(context);
            },
          ),
        ],
      ),
    );
  }
}
