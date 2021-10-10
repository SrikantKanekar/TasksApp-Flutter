import 'package:flutter/material.dart';
import 'package:tasks/model/task_list.dart';
import 'package:tasks/repository/data.dart';
import 'package:tasks/screens/home_screen/my_bottom_bar.dart';
import 'package:tasks/screens/home_screen/my_floating_button.dart';
import 'package:tasks/screens/home_screen/task_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TaskList> taskLists = tasksLists;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: taskLists.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tasks'),
          bottom: TabBar(
            tabs: taskLists.map((list) => Tab(text: list.name)).toList(),
          ),
          actions: [
            IconButton(
              tooltip: 'User',
              icon: const Icon(Icons.person),
              onPressed: () {},
            ),
          ],
        ),
        body: TabBarView(
          children: taskLists
              .map((list) => TaskListWidget(tasks: list.tasks))
              .toList(),
        ),
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: const MyFloatingButton(),
        bottomNavigationBar: const MyBottomBar(),
      ),
    );
  }
}
