import 'package:flutter/material.dart';
import 'package:tasks/model/task.dart';
import 'package:tasks/screens/home_screen/task_lists/task_item.dart';
import 'package:tasks/model/order.dart';

class TaskListWidget extends StatefulWidget {
  final List<Task> tasks;
  final Order order;

  const TaskListWidget({
    Key? key,
    required this.tasks,
    required this.order,
  }) : super(key: key);

  @override
  State<TaskListWidget> createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends State<TaskListWidget> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    List<Task> active = widget.tasks.where((task) => !task.completed).toList();

    if(widget.order == Order.date){
      active.sort((a, b) => b.compareTo(a));
    }

    List<Task> completed =
    widget.tasks.where((task) => task.completed).toList();

    List<Widget> activeWidgets =
    active.map((task) => TaskItem(task: task)).toList();
    List<Widget> completedWidgets =
    expanded ? completed.map((task) => TaskItem(task: task)).toList() : [];

    List<Widget> widgets = [];
    widgets.addAll(activeWidgets);
    if (completed.isNotEmpty) {
      widgets.add(const Divider(height: 0));
      widgets.add(
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 26),
          title: Text('Completed (${completed.length})'),
          trailing: Icon(
              expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
          onTap: () {
            setState(() {
              expanded = !expanded;
            });
          },
        ),
      );
    }
    widgets.addAll(completedWidgets);

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: widgets.length,
      itemBuilder: (ctx, index) => widgets[index],
    );
  }
}
