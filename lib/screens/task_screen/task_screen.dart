import 'package:flutter/material.dart';
import 'package:tasks/model/task.dart';
import 'package:tasks/repository/repository.dart';
import 'package:tasks/screens/task_screen/task_date_time.dart';
import 'package:tasks/screens/task_screen/task_description.dart';
import 'package:tasks/screens/task_screen/task_title.dart';
import 'package:tasks/screens/task_screen/tasks_dropdown.dart';

class TaskScreen extends StatelessWidget {
  static const routeName = '/task';

  TaskScreen({Key? key}) : super(key: key);

  final titleController = TextEditingController();
  final descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var task = ModalRoute.of(context)!.settings.arguments as Task;

    titleController.text = task.name;
    descController.text = task.description;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            tooltip: 'Delete',
            icon: const Icon(Icons.delete),
            onPressed: () {
              // TODO(delete current task)
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          TasksDropdown(task: task),
          TaskTitle(titleController: titleController),
          TaskDescription(descController: descController),
          const TaskDateTime()
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                    task.completed ? 'Mark uncompleted' : 'Mark completed'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
