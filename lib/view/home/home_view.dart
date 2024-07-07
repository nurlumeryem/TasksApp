import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasks_app/bloc/bloc_exports.dart';
import 'package:tasks_app/core/constants/app_assets.dart';
import 'package:tasks_app/core/constants/app_constant.dart';
import 'package:tasks_app/core/locator/locator.dart';
import 'package:tasks_app/widgets/card_container_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    var now = DateTime.now();
    var formattedDate = DateFormat('MMMM d').format(now);

    return BlocProvider.value(
      value: getIt<TasksBloc>(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 160, 143, 206),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Container(
                width: deviceWidth,
                height: deviceHeight / 3,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppAssets.headerImage),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: AppConstant.padding10,
                      child: Row(
                        children: [
                          CircleAvatar(
                              radius: AppConstant.radius50,
                              backgroundImage:
                                  AssetImage(AppAssets.profileImage)),
                          SizedBox(
                            width: AppConstant.width10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hey, Meryem Nurlu  👋",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: AppConstant.font25,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Text(
                      formattedDate,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: AppConstant.font20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppConstant.height10),
                    const Text(
                      "My Todo List",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: AppConstant.font35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Scrollable Cards
              Expanded(
                child: PageView(
                  children: [
                    CardContainerWidget(
                      bgColor: Colors.transparent,
                      child: GridView.count(
                        padding: const EdgeInsets.all(10),
                        crossAxisCount: 2,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 5,
                        children: [
                          Center(
                            child: Image.asset(
                              AppAssets.workImage,
                              width: AppConstant.width200,
                              height: AppConstant.height200,
                            ),
                          ),
                          BlocBuilder<TasksBloc, TasksState>(
                            builder: (context, state) => TaskBox(
                              title: "Pending Tasks",
                              count: state.pendingTasks.length,
                              color: const Color.fromRGBO(103, 58, 183, 1),
                              iconPath: AppAssets.clocImage,
                            ),
                          ),
                          BlocBuilder<TasksBloc, TasksState>(
                            builder: (context, state) => TaskBox(
                              title: "Completed Tasks",
                              count: state.completedTasks.length,
                              color: Colors.deepPurple,
                              iconPath: AppAssets.timeImage,
                            ),
                          ),
                          BlocBuilder<TasksBloc, TasksState>(
                            builder: (context, state) => TaskBox(
                              title: "Favorite Tasks",
                              count: state.favoriteTasks.length,
                              color: Colors.deepPurple,
                              iconPath: AppAssets.starImage,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TaskBox extends StatelessWidget {
  final String title;
  final int? count;
  final Color color;
  final String iconPath;

  const TaskBox({
    Key? key,
    required this.title,
    required this.count,
    required this.color,
    required this.iconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      child: Container(
        color: color,
        child: Stack(
          children: [
            Positioned(
              right: 0,
              child: Image.asset(
                iconPath,
                width: AppConstant.width50,
                height: AppConstant.height50,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: AppConstant.font20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  if (count !=
                      null) // Bu kısım sayıyı kontrol eder ve sadece null değilse gösterir
                    Text(
                      count.toString(),
                      style: const TextStyle(
                        fontSize: AppConstant.font25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
