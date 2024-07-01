import 'package:flutter/material.dart';
import 'package:tasks_app/models/task_model.dart';

class PopupMenu extends StatelessWidget {
  final VoidCallback cancelOrDeleteCallback;
  final VoidCallback likeOrDislikeCallback;
  final VoidCallback editCallback;
  final TaskModel task;

  const PopupMenu({
    Key? key,
    required this.task,
    required this.cancelOrDeleteCallback,
    required this.likeOrDislikeCallback,
    required this.editCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: task.isDeleted == false
          ? ((context) => [
                PopupMenuItem(
                  child: TextButton.icon(
                    onPressed: editCallback,
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit'),
                  ),
                  onTap: null,
                ),
                PopupMenuItem(
                  child: TextButton.icon(
                    onPressed: likeOrDislikeCallback,
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
                    onPressed: cancelOrDeleteCallback,
                    icon: const Icon(Icons.delete),
                    label: const Text('Delete'),
                  ),
                )
              ])
          : (context) => [
                PopupMenuItem(
                  child: TextButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.restore),
                    label: const Text('Restore'),
                  ),
                  onTap: () {},
                ),
                PopupMenuItem(
                  child: TextButton.icon(
                    onPressed: cancelOrDeleteCallback,
                    icon: const Icon(Icons.delete_forever),
                    label: const Text('Delete Forever'),
                  ),
                )
              ],
    );
  }
}
