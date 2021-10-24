import 'package:flutter/material.dart';
import 'package:tasks/blocs/task_lists/task_lists_bloc.dart';
import 'package:tasks/blocs/task_lists/task_lists_provider.dart';
import 'package:tasks/model/task_list.dart';
import 'package:tasks/network/firebase.dart';
import 'package:tasks/screens/home_screen/bottom_bar/my_bottom_bar.dart';
import 'package:tasks/screens/home_screen/new_task/my_floating_button.dart';
import 'package:tasks/screens/home_screen/task_lists/task_list_widget.dart';
import 'package:tasks/screens/home_screen/user/user_dialog.dart';
import 'package:tasks/screens/loading_screen/loading_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TaskListsBloc bloc;
  late TabController _tabController;
  bool synced = false;

  @override
  Future<void> didChangeDependencies() async {
    if (!synced) {
      bloc = TaskListsProvider.of(context);
      await bloc.init();
      await bloc.syncTaskLists();
      await setFirebaseNotification();
    }
    setState(() {
      synced = true;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (!synced) {
      return const LoadingScreen();
    }
    return StreamBuilder(
      stream: bloc.taskLists,
      builder: (context, AsyncSnapshot<List<TaskList>> snapshot) {
        if (!snapshot.hasData) {
          return const LoadingScreen();
        }

        _tabController = TabController(
          initialIndex: bloc.listIndex,
          vsync: this,
          length: snapshot.data!.length,
        );

        _tabController.addListener(() {
          bloc.changeListIndex(_tabController.index);
        });

        bloc.listIndexStream.listen((index) {
          _tabController.animateTo(index);
        });

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Tasks'),
            bottom: TabBar(
              isScrollable: true,
              controller: _tabController,
              tabs: snapshot.data!
                  .map(
                    (list) => Tab(
                      child: Text(
                        capitalize(list.name),
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            actions: [
              IconButton(
                tooltip: 'User',
                icon: const Icon(Icons.person),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) {
                      return const UserDialog();
                    },
                  );
                },
              ),
            ],
          ),
          body: TabBarView(
            controller: _tabController,
            children: snapshot.data!
                .map((list) => TaskListWidget(
                      tasks: list.tasks,
                      order: list.order,
                    ))
                .toList(),
          ),
          resizeToAvoidBottomInset: false,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: const MyFloatingButton(),
          bottomNavigationBar: const MyBottomBar(),
        );
      },
    );
  }

  String capitalize(String string) {
    return string
        .split(" ")
        .map(
          (str) => '${str[0].toUpperCase()}${str.substring(1)}',
        )
        .join(" ");
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
