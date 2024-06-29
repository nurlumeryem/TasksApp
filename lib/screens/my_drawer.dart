import 'package:flutter/material.dart';
import 'package:tasks_app/blocs/bloc_exports.dart';
import 'package:tasks_app/screens/recycle_bin.dart';
import 'package:tasks_app/screens/tabs_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Drawer(
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/task.png',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                color: Colors.deepPurple.withOpacity(0.8),
                child: Text(
                  'Task Drawer',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              BlocBuilder<TasksBloc, TasksState>(
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed(TabsScreen.id),
                    child: ListTile(
                      leading: const Icon(Icons.folder_special),
                      title: const Text('My Tasks'),
                      trailing: Text(
                          '${state.pendingTasks.length}  | ${state.completedTasks.length}'),
                    ),
                  );
                },
              ),
              const Divider(),
              BlocBuilder<TasksBloc, TasksState>(
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed(RecycleBin.id),
                    child: ListTile(
                      leading: const Icon(Icons.folder_special),
                      title: const Text('Bin'),
                      trailing: Text('${state.removedTasks.length}'),
                    ),
                  );
                },
              )
            ],
          ),
        ],
      ),
    ));
  }
}
