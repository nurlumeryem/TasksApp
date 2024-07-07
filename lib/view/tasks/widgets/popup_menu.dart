import 'package:flutter/material.dart';
import 'package:tasks_app/core/routes/routes.manager.dart';
import 'package:tasks_app/models/task_model.dart';

class PopupMenu extends StatelessWidget {
  final VoidCallback deleteCallback;
  final VoidCallback likeOrDislikeCallback;
  final VoidCallback editCallback;
  final TaskModel task;

  const PopupMenu({
    Key? key,
    required this.task,
    required this.deleteCallback,
    required this.likeOrDislikeCallback,
    required this.editCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: task.isDeleted == false
          ? ((context) => [
                PopupMenuItem(
                  // onTap: null,
                  child: TextButton.icon(
                    onPressed: editCallback,
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit'),
                  ),
                ),
                PopupMenuItem(
                  child: TextButton.icon(
                    onPressed: () {
                      likeOrDislikeCallback();
                      router.pop();
                    },
                    icon: task.isFavorite
                        ? const Icon(Icons.bookmark_remove)
                        : const Icon(Icons.bookmark_add_outlined),
                    label: task.isFavorite
                        ? const Text('Remove from Bookmarks')
                        : const Text('Add to Bookmarks'),
                  ),
                ),
                PopupMenuItem(
                  child: TextButton.icon(
                    onPressed: () {
                      deleteCallback();
                      router.pop();
                    },
                    icon: const Icon(Icons.delete),
                    label: const Text('Delete'),
                  ),
                )
              ])
          : (context) => [],
    );
  }
}
