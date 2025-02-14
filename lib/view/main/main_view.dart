import 'package:flutter/material.dart';
import 'package:tasks_app/bloc/bloc_exports.dart';
import 'package:tasks_app/bloc/main_bloc/main_bloc.dart';
import 'package:tasks_app/core/locator/locator.dart';
import 'package:tasks_app/view/tasks/widgets/add_task_widget.dart';
import 'package:tasks_app/view/tasks/completed_tasks_view.dart';
import 'package:tasks_app/view/tasks/favorite_tasks_view.dart';
import 'package:tasks_app/view/home/home_view.dart';
import 'package:tasks_app/view/tasks/pending_view.dart';

class MainView extends StatelessWidget {
  MainView({Key? key}) : super(key: key);

  final List<Widget> _pages = [
    const HomeView(),
    const PendingView(),
    const CompletedTasksScreen(),
    const FavoriteTasksScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainBloc>(
          create: (context) => MainBloc(),
        ),
        BlocProvider.value(
          value: getIt<TasksBloc>(),
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.deepPurple,
        body: BlocBuilder<MainBloc, MainState>(
          builder: (context, state) {
            if (state is TabChangedState) {
              return _pages[state.tabIndex];
            }
            return _pages[0];
          },
        ),
        bottomNavigationBar: const CustomBottomNavigationBar(),
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildIconButton(
                icon: Icons.home,
                isSelected: state is TabChangedState && state.tabIndex == 0,
                onTap: () {
                  context.read<MainBloc>().add(const ChangeTab(0));
                },
              ),
              _buildIconButton(
                icon: Icons.pending,
                isSelected: state is TabChangedState && state.tabIndex == 1,
                onTap: () {
                  context.read<MainBloc>().add(const ChangeTab(1));
                },
              ),
              _buildCenterButton(
                icon: Icons.add,
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: BlocProvider.value(
                          value: getIt<TasksBloc>(),
                          child: const AddTaskScreen(),
                        ),
                      ),
                    ),
                  );
                },
              ),
              _buildIconButton(
                icon: Icons.dashboard_outlined,
                isSelected: state is TabChangedState && state.tabIndex == 2,
                onTap: () {
                  context.read<MainBloc>().add(const ChangeTab(2));
                },
              ),
              _buildIconButton(
                icon: Icons.favorite,
                isSelected: state is TabChangedState && state.tabIndex == 3,
                onTap: () {
                  context.read<MainBloc>().add(const ChangeTab(3));
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return IconButton(
      icon: Icon(icon),
      iconSize: 32,
      color: isSelected ? Colors.amber : Colors.black,
      onPressed: onTap,
    );
  }

  Widget _buildCenterButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70.0,
        height: 70.0,
        decoration: const BoxDecoration(
          color: Colors.deepPurpleAccent,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.orange,
              blurRadius: 12.0,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 45,
        ),
      ),
    );
  }
}
