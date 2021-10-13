import 'package:flutter/material.dart';
import 'package:tasks/blocs/task_lists_bloc.dart';
import 'package:tasks/blocs/task_lists_provider.dart';
import 'package:tasks/model/task_list.dart';
import 'package:tasks/screens/home_screen/my_bottom_bar.dart';
import 'package:tasks/screens/home_screen/my_floating_button.dart';
import 'package:tasks/screens/home_screen/task_list_widget.dart';
import 'package:tasks/screens/loading_screen/loading_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {

  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    final bloc = TaskListsProvider.of(context);

    return StreamBuilder(
      stream: bloc.taskLists,
      builder: (context, AsyncSnapshot<List<TaskList>> snapshot) {
        if (!snapshot.hasData) {
          return const LoadingScreen();
        }

        _tabController = TabController(
          vsync: this,
          length: snapshot.data!.length,
        );

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Tasks'),
            bottom: TabBar(
              controller: _tabController,
              tabs: snapshot.data!.map((list) => Tab(text: list.name)).toList(),
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
            controller: _tabController,
            children: snapshot.data!
                .map((list) => TaskListWidget(tasks: list.tasks))
                .toList(),
          ),
          resizeToAvoidBottomInset: false,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: const MyFloatingButton(),
          bottomNavigationBar: MyBottomBar(
            changeTab: (index) {
              _tabController.animateTo(index);
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
