import 'dart:async';

import 'package:tasks/model/task_list.dart';
import 'package:tasks/repository/data.dart';

class TaskListBloc {
  TaskListBloc() {
    _taskListController.sink.add(tasksLists);
  }

  final _taskListController = StreamController<List<TaskList>>();

  Stream<List<TaskList>> get tasks => _taskListController.stream;

  dispose() {
    _taskListController.close();
  }
}
