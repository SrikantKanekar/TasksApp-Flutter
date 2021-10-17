import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasks/blocs/task_lists_provider.dart';
import 'package:tasks/model/task.dart';
import 'package:tasks/screens/task_screen/task_screen.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  const TaskItem({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = TaskListsProvider.of(context);
    return ListTile(
      leading: IconButton(
        onPressed: () {
          bloc.toggleCompleted(task);
        },
        icon: Icon(
          task.completed ? Icons.check : Icons.radio_button_off,
        ),
      ),
      title: Text(
        task.name,
        style: TextStyle(
          overflow: TextOverflow.ellipsis,
          decoration:
              task.completed ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
      trailing: task.dateTime != null
          ? Stack(
              children: [
                Chip(
                  label: Text(
                    DateFormat.MMMEd().format(task.dateTime!),
                    style: TextStyle(
                      color: task.dateTime!.isBefore(DateTime.now())
                          ? Theme.of(context).colorScheme.error
                          : Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                  shape: StadiumBorder(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ),
              ],
            )
          : null,
      onTap: () {
        Navigator.of(context)
            .pushNamed(TaskScreen.routeName, arguments: task.id);
      },
    );
  }
}
