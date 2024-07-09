import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_app/bloc/bloc_exports.dart';
import 'package:tasks_app/view/tasks/widgets/tasks_list.dart';

import '../../models/task_model.dart';

class PendingView extends StatelessWidget {
  const PendingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<TaskModel> tasksList = state.pendingTasks;
        List<TaskModel> searchResults = state.searchResults;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurpleAccent,
            centerTitle: true,
            title: const Text(
              'Pending Tasks',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.only(top: 5, left: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.8),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    onChanged: (query) {
                      BlocProvider.of<TasksBloc>(context)
                          .add(SearchTaskEvent(query));
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: "Task Search",
                      prefixIcon:
                          Icon(Icons.search, color: Colors.deepPurpleAccent),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Chip(
                    label: Text(
                      '${tasksList.length} Tasks',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TasksList(
                  tasksList:
                      searchResults.isNotEmpty ? searchResults : tasksList,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
