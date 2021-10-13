import 'package:flutter/material.dart';
import 'package:tasks/blocs/task_lists_bloc.dart';

class TaskListsProvider extends InheritedWidget {
  final TaskListsBloc bloc;

  TaskListsProvider({
    Key? key,
    required Widget child,
  })  : bloc = TaskListsBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static TaskListsBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<TaskListsProvider>()
            as TaskListsProvider)
        .bloc;
  }
}
