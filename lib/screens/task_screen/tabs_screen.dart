import 'package:flutter/material.dart';
import 'package:tasks_app/screens/task_screen/add_task_screen.dart';
import 'package:tasks_app/screens/task_screen/completed_tasks_screen.dart';
import 'package:tasks_app/screens/task_screen/favorite_tasks_screen.dart';
import 'package:tasks_app/screens/task_screen/home_screen.dart';

import 'package:tasks_app/screens/task_screen/pending_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});
  static const id = 'tabs_screen';

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, dynamic>> _pageDetails = [
    {'pageName': const HomeScreen(), 'title': 'HomeScreen', 'showTitle': false},
    {
      'pageName': const PendingTasksScreen(),
      'title': 'Pending Tasks',
      'showTitle': true
    },
    {
      'pageName': const CompletedTasksScreen(),
      'title': 'Completed Tasks',
      'showTitle': true
    },
    {
      'pageName': const FavoriteTasksScreen(),
      'title': 'FavoriteTasks',
      'showTitle': true
    },
  ];

  var _selectedPageIndex = 1;

  void _addTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => SingleChildScrollView(
                child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: const AddTaskScreen(),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: _pageDetails[_selectedPageIndex]['showTitle']
            ? Text(_pageDetails[_selectedPageIndex]['title'])
            : null,
      ),
      body: SafeArea(
        child: _pageDetails[_selectedPageIndex]['pageName'],
      ),
      floatingActionButton: _selectedPageIndex == 1
          ? FloatingActionButton(
              onPressed: () => _addTask(context),
              tooltip: 'Add Task',
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: (index) {
          setState(() {
            _selectedPageIndex = index;
          });
        },
        selectedItemColor: const Color.fromARGB(255, 72, 30, 185),
        unselectedItemColor: Colors.grey,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home Screen'),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.incomplete_circle_sharp,
            ),
            label: 'Pending Tasks',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.done), label: 'Completed Tasks'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorite Tasks'),
        ],
      ),
    );
  }
}
