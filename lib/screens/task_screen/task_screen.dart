import 'package:flutter/material.dart';
import 'package:tasks/blocs/task_lists/task_lists_bloc.dart';
import 'package:tasks/blocs/task_lists/task_lists_provider.dart';
import 'package:tasks/model/task.dart';
import 'package:tasks/screens/loading_screen/loading_screen.dart';
import 'package:tasks/screens/task_screen/task_date_time.dart';
import 'package:tasks/screens/task_screen/task_description.dart';
import 'package:tasks/screens/task_screen/task_title.dart';
import 'package:tasks/screens/task_screen/tasks_dropdown.dart';

class TaskScreen extends StatefulWidget {
  static const routeName = '/task';

  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  Task? task;
  TaskListsBloc? bloc;
  final titleController = TextEditingController();
  final descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      var taskId = ModalRoute.of(context)!.settings.arguments as String;
      bloc = TaskListsProvider.of(context);
      task = await bloc!.getTaskById(taskId);
      titleController.text = task!.name;
      descController.text = task!.description;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (task == null) {
      return const LoadingScreen();
    }
    return WillPopScope(
      onWillPop: () async {
        bloc!.updateTask(
          Task(
            id: task!.id,
            name: titleController.text,
            description: descController.text,
            dateTime: task!.dateTime,
            completed: task!.completed,
          ),
        );
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              tooltip: 'Delete',
              icon: const Icon(Icons.delete),
              onPressed: () {
                bloc!.deleteTask(task!);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        body: ListView(
          children: [
            TasksDropdown(
              onChanged: (value) => bloc!.changeTaskList(task!, value!),
            ),
            TaskTitle(titleController: titleController),
            TaskDescription(descController: descController),
            TaskDateTime(
              dateTime: task!.dateTime,
              update: (dateTime) {
                setState(() {
                  task!.dateTime = dateTime;
                });
              },
              clear: () {
                setState(() {
                  task!.dateTime = null;
                });
              },
            )
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      task!.completed = !task!.completed;
                    });
                  },
                  child: Text(
                    task!.completed ? 'Mark uncompleted' : 'Mark completed',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
