import 'package:flutter/material.dart';
import 'package:tasks/model/task.dart';
import 'package:tasks/widgets/task_item.dart';

class TaskListWidget extends StatelessWidget {
  final List<Task> tasks;

  const TaskListWidget({
    Key? key,
    required this.tasks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (ctx, index) => TaskItem(
        task: tasks[index],
      ),
    );
  }
}
