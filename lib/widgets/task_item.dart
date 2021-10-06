import 'package:flutter/material.dart';
import 'package:tasks/model/task.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  const TaskItem({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      value: task.completed,
      groupValue: true,
      title: Text(task.name),
      onChanged: (bool? value) {},
    );
  }
}
